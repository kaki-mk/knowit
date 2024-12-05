package model;

import java.io.IOException;

public class CallPythonScript {

	public void execute(String fileName) {

		// script.pyを呼び出す
		ProcessBuilder pb = new ProcessBuilder("python", "D:\\pleiades\\2024-09\\workspace\\knowit\\src\\main\\python\\ocr.py", fileName);

		// Pythonコードの標準出力をJavaの標準出力に出す
		pb.redirectOutput(ProcessBuilder.Redirect.INHERIT);
		pb.redirectError(ProcessBuilder.Redirect.INHERIT);
		try {
			// pythonスクリプトを実行する
			Process process = pb.start();
			// 実行完了までJava側のコードを待機させ、終了コードを出す
			int exitCode = process.waitFor();
			// 正常終了したか、終了コードで判定
			if (exitCode == 0) {
				System.out.println("Python script executed successfully.");
			} else {
				System.out.println("Python script failed with exit code: " + exitCode);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

	}
}
