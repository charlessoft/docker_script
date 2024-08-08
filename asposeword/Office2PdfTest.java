import com.aspose.words.Document;
import com.aspose.words.SaveFormat;

import java.io.File;
import java.io.FileOutputStream;

public class Office2PdfTest {
    public static void main(String[] args) {
        if (args.length < 2) {
            System.out.println("Usage: java Office2PdfTest <input file> <output file>");
            return;
        }

        try {
            String src = args[0];
            String dst = args[1];
            long start = System.currentTimeMillis();
            File file = new File(dst);
            FileOutputStream os = new FileOutputStream(file);
            Document doc = new Document(src);
            doc.save(os, SaveFormat.PDF);
            os.close();
            System.out.println("convert cost " + (System.currentTimeMillis() - start) + "ms");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
