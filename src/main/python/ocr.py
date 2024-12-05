import torch
import sys
import json
import random
import csv
import jaydebeapi
import psycopg2

from transformers import BertTokenizer, BertModel
from scipy.spatial.distance import cosine
from google.cloud import documentai_v1 as documentai

# BERTモデルとトークナイザーをロード
model_name = "cl-tohoku/bert-base-japanese-whole-word-masking"
tokenizer = BertTokenizer.from_pretrained(model_name)
model = BertModel.from_pretrained(model_name)

# GPUが利用できる場合はGPUを使用
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = model.to(device)

# 埋め込みを取得する関数
def get_embedding(text):
    # トークン化してテンソルに変換
    inputs = tokenizer(text, return_tensors="pt", padding=True, truncation=True, max_length=512)
    inputs = {key: value.to(device) for key, value in inputs.items()}  # GPUに転送
    
    # BERTモデルで埋め込みベクトルを取得
    with torch.no_grad():
        outputs = model(**inputs)
    
    # [CLS]トークンの埋め込みベクトルを取り出す
    embedding = outputs.last_hidden_state[:, 0, :].cpu().numpy()  # 1次元ベクトルを取得
    return embedding.flatten()  # 1次元に変換

# コサイン類似度を計算する関数
def calculate_cosine_similarity(embedding1, embedding2):
    return 1 - cosine(embedding1, embedding2)


def process_document(project_id: str, location: str,
                     processor_id: str, file_path: str,
                     mime_type: str) -> documentai.Document:
    """
    Processes a document using the Document AI API.
    """

 
    # Instantiates a client
    documentai_client = documentai.DocumentProcessorServiceClient()
    
    # The full resource name of the processor, e.g.:
    # projects/project-id/locations/location/processor/processor-id
    # You must create new processors in the Cloud Console first
    resource_name = documentai_client.processor_path(
        project_id, location, processor_id)
 
    # Read the file into memory
    with open(file_path, "rb") as image:
        image_content = image.read()
 
        # Load Binary Data into Document AI RawDocument Object
        raw_document = documentai.RawDocument(
            content=image_content, mime_type=mime_type)
 
        # Configure the process request
        request = documentai.ProcessRequest(
            name=resource_name, raw_document=raw_document)
 
        # Use the Document AI client to process the sample form
        result = documentai_client.process_document(request=request)
 
        return result.document
 
def main():
    """
    Run the codelab.
    """
    project_id = 'knowit-441711'
    location = 'us'  # Format is 'us' or 'eu'
    processor_id = '4e43166f60f55f44'  # Create processor in Cloud Console
 
    file_path = 'D:\\pleiades\\2024-09\\workspace\\knowit\\src\\main\\webapp\\WEB-INF\\img\\' + sys.argv[1]  # The local file in your current working directory
    # Refer to https://cloud.google.com/document-ai/docs/processors-list for the supported file types
    mime_type = 'image/png'
 
    document = process_document(project_id=project_id, location=location,
                                processor_id=processor_id, file_path=file_path,
                                mime_type=mime_type)
 
    print("Document processing complete.")
    print(document.text)
 
    dsn = "dbname=knowit host=10.23.107.251 user=user password=password"

    with psycopg2.connect(dsn) as conn:
        with conn.cursor() as cur:
            cur.execute("select \"QID\", \"QTXT\" from knowit.\"QUESTION\" order by \"QID\"")  # クエリの実行
            qList = cur.fetchall()
 
    similarityList = [["QID", "score"]] 
    for i in qList:
        
         #str(random.randint(100000000, 999999999))

        # 例として比較する2つの日本語の文
        text1 = document.text
        text2 = i[1]

        # テキストから埋め込みベクトルを取得
        embedding1 = get_embedding(text1)
        embedding2 = get_embedding(text2)

        
        
        # コサイン類似度を計算
        similarity = calculate_cosine_similarity(embedding1, embedding2)
        similarityList.append([i[0], float(similarity)])
        
    for i in similarityList:
        # 類似度の表示
        # #print(f"コサイン類似度: {similarity:.4f}")
        print(i)

    with open('D:\\pleiades\\2024-09\\workspace\\knowit\\src\\main\\webapp\\WEB-INF\\csv\\'+sys.argv[1]+'.csv', 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerows(similarityList)

if __name__ == "__main__":
    main()  
