package model;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class SortByScore {
	public List<String[]> execute(String fileName) {
		String filePath = "D:\\pleiades\\2024-09\\workspace\\knowit\\src\\main\\webapp\\WEB-INF\\csv\\"+fileName+".csv"; // CSVファイルのパス
		List<String[]> records = new ArrayList<>();

		try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
			String line;
			boolean isHeader = true; // ヘッダー行をスキップするためのフラグ
			while ((line = br.readLine()) != null) {
				if (isHeader) {
					isHeader = false;
					continue; // ヘッダー行をスキップ
				}
				// CSVの各行をカンマで分割して配列に変換
				String[] values = line.split(",");
				records.add(values);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		// scoreの降順でソート（第2要素がスコアと仮定）
		records.sort((record1, record2) -> {
			double score1 = Double.parseDouble(record1[1]); // スコアをdoubleに変換
			double score2 = Double.parseDouble(record2[1]);
			return Double.compare(score2, score1); // 降順のため引数の順序を逆に
		});
		
		return records;
	}
}
