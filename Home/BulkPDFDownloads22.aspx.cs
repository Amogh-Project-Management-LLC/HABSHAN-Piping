using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using dsMainTablesATableAdapters;
using Ionic.Zip;
using System.IO;
using Microsoft.Reporting.WebForms;
using dsSpoolReportsATableAdapters;
using dsSpoolReportsCTableAdapters;
using dsWeldingReportsBTableAdapters;
using Telerik.Web.UI;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Data.OracleClient;
using System.Text;


public partial class Home_BulkPDFDownloads : System.Web.UI.Page
{
    string sample_table_name;
    string sample_export_type;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (WebTools.UserInRole("PIP_READ_ONLY_USER"))
            {
                Response.Redirect("~/ErrorPages/NoAccess.htm");
                return;
            }
           Master.HeadingMessage = "Bulk PDF Downloads";
        }
     }

    public void createTable(string FileName, int spl_id, string id_1)
    {
        var r = new Rectangle(220, 144)
        {
            //BackgroundColor=new BaseColor(179,227,238), remove this in original code
            Border = 0
        };
        Document dc = new Document(r, 0, 0, 0, 0);
        // PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + spl_id + ".pdf", FileMode.Create));

        PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + id_1 + ".pdf", FileMode.Create));
        dc.Open();
        // BaseFont customfont = BaseFont.CreateFont("d:\\ss.ttf", BaseFont.CP1252, BaseFont.EMBEDDED);
        BaseFont customfont = BaseFont.CreateFont();
        int a = spl_id;
        //string connectionString = "Data Source=ALRAR;Persist Security Info=True;User ID=AMOGH;Password=ALRAR2020;Unicode=True";
        OracleConnection conn = WebTools.GetIpmsConnection();
        // string query = "SELECT iso_title1,spl_rev,spool,round(spl_size,2) as spl_size ,area_l1,round(weight,2),mat_type,line_no,unit FROM view_total_spool_list WHERE spl_id=" + spl_id;
        string query = "SELECT iso_title1,spl_rev,spool,nvl(spl_size, 0) as spl_size,nvl(area_l1, 'XXX') as area_l1,nvl(weight, 0) as weight,nvl(unit, 'XXX') as unit, nvl(mat_type, 'UNK') as mat_type, nvl(line_no, '-') AS LINE_NO, nvl(AIM_NO,'-') AS UNIQUE_NO FROM view_bc_image_dt WHERE spl_id=" + spl_id;
        OracleCommand cmd = new OracleCommand(query, conn);
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        OracleDataReader rdr = cmd.ExecuteReader();
        // Font bigFont = new Font(Font.FontFamily.TIMES_ROMAN, 6.5f, Font.NORMAL);
        Font bigFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 8, Font.BOLD, BaseColor.BLACK);
        Font smallFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 7, Font.BOLD, BaseColor.BLACK);
        Font headfont = new Font(Font.FontFamily.COURIER, 14f, Font.BOLD);
        iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;
        Barcode128 bc = new Barcode128();
        bc.ChecksumText = true;
        bc.Code = a.ToString().PadLeft(16, '0');
        bc.Size = 4;
        bc.BarHeight = 15;
        bc.Baseline = 4;
        PdfPTable table = new PdfPTable(2);
        // table.SetWidths(new float[]{158,68});
        table.SetWidthPercentage(new float[] { 100, 100 }, r);
        table.SetWidths(new float[] { 145, 80 });
        table.DefaultCell.Border = Rectangle.NO_BORDER;
        table.DefaultCell.NoWrap = true;
        // PdfPCell cell = new PdfPCell(new Paragraph("Petrofac / Rabigh"));
        PdfPCell cell = new PdfPCell(new Paragraph("Job: PSJV/JI-2037", headfont));
        cell.Colspan = 2;
        cell.Rowspan = 4;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        cell.Border = 0;
        cell.Padding = 4;
        table.AddCell(cell);
        cell = new PdfPCell();
        cell.Image = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        cell.Colspan = 2;
        cell.Border = 0;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        table.AddCell(cell);
        rdr.Read();
        table.AddCell(new Paragraph("Iso:" + rdr[0].ToString(), smallFont));
        table.AddCell(new Paragraph("Rev:" + rdr[1].ToString(), bigFont));
        table.AddCell(new Paragraph("Spool:" + rdr[2].ToString(), bigFont));
        table.AddCell(new Paragraph("Spool-Size:" + rdr[3].ToString(), bigFont));
        table.AddCell(new Paragraph("Wbs-No:" + rdr[4].ToString(), bigFont));
        table.AddCell(new Paragraph("Weight:" + rdr[5].ToString(), bigFont));
        table.AddCell(new Paragraph("Unit:" + rdr[6].ToString(), bigFont));
        table.AddCell(new Paragraph("Mat:" + rdr[7].ToString(), bigFont));
        table.AddCell(new Paragraph("Line:" + rdr[8].ToString(), smallFont));
        table.AddCell(new Paragraph("UniqueNo:" + rdr[9].ToString(), smallFont));
        table.AddCell("");
        //NEW  CONDITION
        rdr.Close();
        //END
        conn.Close();
        dc.Add(table);
        dc.Close();
    }




    public void createTable_QR(string FileName, int spl_id, string id_1)
    {
        //PdfPTable table = new PdfPTable(8);

        //PdfPCell cell;

        //cell = new PdfPCell();
        ////cell.setRowspan(2);
        //cell.Rowspan = 2;
        //table.AddCell(cell);

        //for (int aw = 0; aw < 8; aw++)
        //{
        //    table.AddCell("hi");
        //}


        System.Text.Encoding enc = new System.Text.UTF8Encoding(true, true);

        //Get the BOM
        byte[] bom = enc.GetPreamble();

        //Get the raw bytes for the string
        byte[] bytes = enc.GetBytes("");


        //Combine the byte arrays
        byte[] final = new byte[bom.Length + bytes.Length];
        System.Buffer.BlockCopy(bom, 0, final, 0, bom.Length);
        System.Buffer.BlockCopy(bytes, 0, final, bom.Length, bytes.Length);

        var r = new Rectangle(165, 71)
        {
            //BackgroundColor=new BaseColor(179,227,238), remove this in original code
            Border = 0
        };

        Document dc = new Document(r, 0, 0, 0, 0);



        PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + id_1 + ".pdf", FileMode.Create));

        dc.Open();

        // BaseFont customfont = BaseFont.CreateFont("d:\\ss.ttf", BaseFont.CP1252, BaseFont.EMBEDDED);
        BaseFont customfont = BaseFont.CreateFont();
        int a = spl_id;
        string connectionString = WebTools.GetIpmsConnection().ConnectionString;
        OracleConnection conn = new OracleConnection(connectionString);
        // string query = "SELECT iso_title1,spl_rev,spool,round(spl_size,2) as spl_size ,area_l1,round(weight,2),mat_type,line_no,unit FROM view_total_spool_list WHERE spl_id=" + spl_id;
        string query = "SELECT iso_title1,spl_rev,spool,spl_size,area_l1,weight,unit,mat_type,line_no FROM view_bc_image_dt WHERE spl_id=" + spl_id;
        OracleCommand cmd = new OracleCommand(query, conn);
        conn.Open();
        OracleDataReader rdr = cmd.ExecuteReader();
        // Font bigFont = new Font(Font.FontFamily.TIMES_ROMAN, 6.5f, Font.NORMAL);
        Font bigFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 6.3f, Font.BOLD, BaseColor.BLACK);
        Font headfont = new Font(Font.FontFamily.COURIER, 14f, Font.BOLD);
        iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;


        rdr.Read();

        string qrstring = rdr[0].ToString() + " / " + rdr[2].ToString();

        BarcodeQRCode bcd = new BarcodeQRCode(qrstring.ToString(), 7000, 7000, null);



        // a table with three columns
        PdfPTable table_100 = new PdfPTable(2);
        //  table_100.SetWidthPercentage(new float[] { 40, 120 }, r);
        //  table_100.SetWidths(new float[] { 50, 120 });

        table_100.SetWidthPercentage(new float[] { 75, 100 }, r);
        table_100.SetWidths(new float[] { 75, 100 });
        table_100.DefaultCell.Border = Rectangle.NO_BORDER;
        // the cell object
        PdfPCell cell_100 = new PdfPCell();

        table_100.HorizontalAlignment = Element.ALIGN_LEFT;

        cell_100.Border = 0;
        cell_100.PaddingTop = 3;

        cell_100.Image = iTextSharp.text.Image.GetInstance(bcd.GetImage());

        cell_100.HorizontalAlignment = 0; //0=Left, 1=Centre, 2=Right

        table_100.AddCell(cell_100);

        //var splitter =  "Iso:" + rdr[0].ToString() + "\n" + "\n" + "Spool:" + rdr[2].ToString();

        var splitter = "Line No :" + rdr[8].ToString() + "\n" + "\n" + "Iso:" + rdr[0].ToString() + "\n" + "\n" + "Spool:" + rdr[2].ToString() + "\n" + "\n" + "Weight:" + rdr[5].ToString();

        var splitter1 = splitter.Split('_');

        //var splitter1 = splitter.Split('_');

        iTextSharp.text.Paragraph paragraph;
        paragraph = new Paragraph();

        paragraph.Add(new Chunk(ConvertStringArrayToString(splitter1), bigFont));
        cell_100 = new PdfPCell(paragraph);
        cell_100.PaddingTop = 8;
        cell_100.Border = 0;

        table_100.AddCell(cell_100);

        //table_100.AddCell(new Paragraph(ConvertStringArrayToString(splitter1), bigFont));

        conn.Close();
        dc.Add(table_100);
        dc.Close();




    }


    static string ConvertStringArrayToString(string[] array)
    {
        // Concatenate all the elements into a StringBuilder.
        StringBuilder builder = new StringBuilder();
        //  builder.Append("                                                                                                                  ");
        foreach (string value in array)
        {
            builder.Append(value);
            //builder.Append("    ");



            //sb.ToString().Replace(Environment.NewLine, "<br />");
        }
        return builder.ToString().Replace(Environment.NewLine, "\n");
    }


    public void createTable_NEW(string FileName, int spl_id, string id_1)
    {
        var r = new Rectangle(220, 144)
        {
            //BackgroundColor=new BaseColor(179,227,238), remove this in original code
            Border = 0
        };
        Document dc = new Document(r, 0, 0, 0, 0);
        // PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + spl_id + ".pdf", FileMode.Create));

        PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + id_1 + ".pdf", FileMode.Create));
        dc.Open();
        // BaseFont customfont = BaseFont.CreateFont("d:\\ss.ttf", BaseFont.CP1252, BaseFont.EMBEDDED);
        BaseFont customfont = BaseFont.CreateFont();
        int a = spl_id;
        //string connectionString = "Data Source=ALRAR;Persist Security Info=True;User ID=AMOGH;Password=ALRAR2020;Unicode=True";
        OracleConnection conn = WebTools.GetIpmsConnection();
        // string query = "SELECT iso_title1,spl_rev,spool,round(spl_size,2) as spl_size ,area_l1,round(weight,2),mat_type,line_no,unit FROM view_total_spool_list WHERE spl_id=" + spl_id;

        string query = "SELECT mat_code1,heat_no,nvl(paint_code,'NA')  as paint_code,wall_thk,joint_thk,size1,nvl(mat_type,'XXX') as mat_type,substr(mat_descr,1,100) AS mat_descr, SubStr(mat_descr,101,100) AS mat_descr2, SubStr(mat_descr,201,100) AS mat_descr3 FROM  view_bulk_paint_barcode WHERE spl_id=" + spl_id;


        OracleCommand cmd = new OracleCommand(query, conn);
        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }
        OracleDataReader rdr = cmd.ExecuteReader();
        // Font bigFont = new Font(Font.FontFamily.TIMES_ROMAN, 6.5f, Font.NORMAL);
        Font bigFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 8, Font.BOLD, BaseColor.BLACK);
        Font smallFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 7, Font.BOLD, BaseColor.BLACK);
        Font mediumFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 6, Font.BOLD, BaseColor.BLACK);
        Font mediumFont_a = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 4, Font.BOLD, BaseColor.BLACK);
        Font headfont = new Font(Font.FontFamily.COURIER, 14f, Font.BOLD);
        iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;
        Barcode128 bc = new Barcode128();
        bc.ChecksumText = true;
        bc.Code = a.ToString().PadLeft(16, '0');
        bc.Size = 4;
        bc.BarHeight = 15;
        bc.Baseline = 4;
        PdfPTable table = new PdfPTable(2);
        // table.SetWidths(new float[]{158,68});
        table.SetWidthPercentage(new float[] { 100, 100 }, r);
        table.SetWidths(new float[] { 145, 80 });
        table.DefaultCell.Border = Rectangle.NO_BORDER;
        table.DefaultCell.NoWrap = true;
        // PdfPCell cell = new PdfPCell(new Paragraph("Petrofac / Rabigh"));
        PdfPCell cell = new PdfPCell(new Paragraph("Job: PSJV/JI-2037", headfont));
        cell.Colspan = 2;
        cell.Rowspan = 4;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        cell.Border = 0;
        cell.Padding = 4;
        table.AddCell(cell);
        cell = new PdfPCell();
        cell.Image = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        cell.Colspan = 2;
        cell.Border = 0;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        table.AddCell(cell);
        rdr.Read();

        //table.AddCell(new Paragraph("Item code:" + rdr[0].ToString(), smallFont));
        //table.AddCell(new Paragraph("Paint Code:" + rdr[2].ToString(), bigFont));
        //table.AddCell(new Paragraph("Heat No:" + rdr[1].ToString(), bigFont));
        //table.AddCell(new Paragraph("Sch & Thk:" + rdr[3].ToString() + " & " + rdr[4].ToString(), bigFont));
        //table.AddCell(new Paragraph("Pipe-Size:" + rdr[5].ToString(), bigFont));
        //table.AddCell(new Paragraph("Main-Mat:" + rdr[6].ToString(), bigFont));
        //table.AddCell(new Paragraph("Pipe-Description:" + rdr[7].ToString(), bigFont));

        table.AddCell(new Paragraph("Item code:" + rdr[0].ToString(), mediumFont));
        table.AddCell(new Paragraph("Paint Code:" + rdr[2].ToString(), mediumFont));
        table.AddCell(new Paragraph("Heat No:" + rdr[1].ToString(), mediumFont));
        table.AddCell(new Paragraph("Sch & Thk:" + rdr[3].ToString() + " & " + rdr[4].ToString(), mediumFont));
        table.AddCell(new Paragraph("Pipe-Size:" + rdr[5].ToString(), mediumFont));
        table.AddCell(new Paragraph("Main-Mat:" + rdr[6].ToString(), mediumFont));
        table.AddCell(new Paragraph("Pipe-Description:" + rdr[7].ToString(), mediumFont_a));
        table.AddCell(new Paragraph(rdr[8].ToString(), mediumFont_a));
        table.AddCell(new Paragraph(rdr[9].ToString(), mediumFont_a));



        //table.AddCell(new Paragraph("Mat:" + rdr[7].ToString(), bigFont));
        //table.AddCell(new Paragraph("Line:" + rdr[8].ToString(), bigFont));
        table.AddCell("");
        //NEW  CONDITION
        rdr.Close();
        //END
        conn.Close();
        dc.Add(table);
        dc.Close();
    }



    public void createTable_NEW_QR(string FileName, int spl_id, string id_1)
    {
        System.Text.Encoding enc = new System.Text.UTF8Encoding(true, true);

        //Get the BOM
        byte[] bom = enc.GetPreamble();

        //Get the raw bytes for the string
        byte[] bytes = enc.GetBytes("");

        //Combine the byte arrays
        byte[] final = new byte[bom.Length + bytes.Length];
        System.Buffer.BlockCopy(bom, 0, final, 0, bom.Length);
        System.Buffer.BlockCopy(bytes, 0, final, bom.Length, bytes.Length);

        var r = new Rectangle(160, 100)
        {
            //BackgroundColor=new BaseColor(179,227,238), remove this in original code
            Border = 0
        };


        Document dc = new Document(r, 0, 0, 0, 0);

        // PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + spl_id + ".pdf", FileMode.Create));

        PdfWriter writer = PdfWriter.GetInstance(dc, new FileStream(HttpContext.Current.Request.PhysicalApplicationPath + FileName + "/" + id_1 + ".pdf", FileMode.Create));
        dc.Open();

        // BaseFont customfont = BaseFont.CreateFont("d:\\ss.ttf", BaseFont.CP1252, BaseFont.EMBEDDED);

        BaseFont customfont = BaseFont.CreateFont();
        int a = spl_id;

        //string connectionString = "Data Source=ALRAR;Persist Security Info=True;User ID=AMOGH;Password=ALRAR2020;Unicode=True";

        OracleConnection conn = WebTools.GetIpmsConnection();

        // string query = "SELECT iso_title1,spl_rev,spool,round(spl_size,2) as spl_size ,area_l1,round(weight,2),mat_type,line_no,unit FROM view_total_spool_list WHERE spl_id=" + spl_id;

        string query = "SELECT mat_code1,heat_no,nvl(paint_code,'NA')  as paint_code,wall_thk,joint_thk,size1,nvl(mat_type,'XXX') as mat_type,substr(mat_descr,1,100) AS mat_descr, SubStr(mat_descr,101,100) AS mat_descr2, SubStr(mat_descr,201,100) AS mat_descr3 FROM  view_bulk_paint_barcode WHERE spl_id=" + spl_id;


        OracleCommand cmd = new OracleCommand(query, conn);

        if (conn.State == ConnectionState.Closed)
        {
            conn.Open();
        }


        OracleDataReader rdr = cmd.ExecuteReader();
        // Font bigFont = new Font(Font.FontFamily.TIMES_ROMAN, 6.5f, Font.NORMAL);
        Font bigFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 8, Font.BOLD, BaseColor.BLACK);
        Font smallFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 7, Font.BOLD, BaseColor.BLACK);
        Font mediumFont = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 6, Font.BOLD, BaseColor.BLACK);
        Font mediumFont_a = FontFactory.GetFont("Calibri", BaseFont.CP1252, BaseFont.EMBEDDED, 4, Font.BOLD, BaseColor.BLACK);
        Font headfont = new Font(Font.FontFamily.COURIER, 14f, Font.BOLD);
        iTextSharp.text.pdf.PdfContentByte cb = writer.DirectContent;


        //table.AddCell(new Paragraph("Item code:" + rdr[0].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Paint Code:" + rdr[2].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Heat No:" + rdr[1].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Sch & Thk:" + rdr[3].ToString() + " & " + rdr[4].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Pipe-Size:" + rdr[5].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Main-Mat:" + rdr[6].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Pipe-Description:" + rdr[7].ToString(), mediumFont_a));
        //table.AddCell(new Paragraph(rdr[8].ToString(), mediumFont_a));
        //table.AddCell(new Paragraph(rdr[9].ToString(), mediumFont_a));


        rdr.Read();
        string s1 = "Item-Code / Paint-Code :" + "  " + rdr[0].ToString() + "/" + rdr[2].ToString();
        string s2 = "  " + "Heat-No / Sch &Thk :" + " " + rdr[1].ToString() + "/" + rdr[3].ToString() + " & " + rdr[4].ToString();
        string s3 = "  " + "Pipe-Size / Main-Mat :" + rdr[5].ToString() + "/" + rdr[6].ToString();
        string s4 = "  " + "Pipe-Description :" + rdr[7].ToString();

        BarcodeQRCode bcd = new BarcodeQRCode(s1.ToString() + "    " + s2.ToString() + "    " + s3.ToString() + "    " + s4.ToString(), 10, 10, null);

        PdfPTable table = new PdfPTable(2);

        table.SetWidthPercentage(new float[] { 70, 70 }, r);
        //table.SetWidths(new float[] { 145, 80 });
        table.SetWidths(new float[] { 100, 80 });
        table.DefaultCell.Border = Rectangle.NO_BORDER;
        table.DefaultCell.NoWrap = true;

        // PdfPCell cell = new PdfPCell(new Paragraph("Petrofac / Rabigh"));
        //PdfPCell cell = new PdfPCell(new Paragraph("Petrofac / JI-2014", headfont));
        PdfPCell cell = new PdfPCell();
        cell.Image = iTextSharp.text.Image.GetInstance(bcd.GetImage());


        cell.Colspan = 2;
        cell.Border = 0;
        cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        table.AddCell(cell);


        conn.Close();
        dc.Add(table);
        dc.Close();



        //Barcode128 bc = new Barcode128();
        //bc.ChecksumText = true;
        //bc.Code = a.ToString().PadLeft(16, '0');
        //bc.Size = 4;
        //bc.BarHeight = 15;
        //bc.Baseline = 4;
        //PdfPTable table = new PdfPTable(2);
        //// table.SetWidths(new float[]{158,68});
        //table.SetWidthPercentage(new float[] { 100, 100 }, r);
        //table.SetWidths(new float[] { 145, 80 });
        //table.DefaultCell.Border = Rectangle.NO_BORDER;
        //table.DefaultCell.NoWrap = true;
        //// PdfPCell cell = new PdfPCell(new Paragraph("Petrofac / Rabigh"));
        //PdfPCell cell = new PdfPCell(new Paragraph("Job: Petrofac/JI-2037", headfont));
        //cell.Colspan = 2;
        //cell.Rowspan = 4;
        //cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        //cell.Border = 0;
        //cell.Padding = 4;
        //table.AddCell(cell);
        //cell = new PdfPCell();
        //cell.Image = iTextSharp.text.Image.GetInstance(bc.CreateImageWithBarcode(cb, null, null));
        //cell.Colspan = 2;
        //cell.Border = 0;
        //cell.HorizontalAlignment = 1; //0=Left, 1=Centre, 2=Right
        //table.AddCell(cell);
        //rdr.Read();


        //table.AddCell(new Paragraph("Item code:" + rdr[0].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Paint Code:" + rdr[2].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Heat No:" + rdr[1].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Sch & Thk:" + rdr[3].ToString() + " & " + rdr[4].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Pipe-Size:" + rdr[5].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Main-Mat:" + rdr[6].ToString(), mediumFont));
        //table.AddCell(new Paragraph("Pipe-Description:" + rdr[7].ToString(), mediumFont_a));
        //table.AddCell(new Paragraph(rdr[8].ToString(), mediumFont_a));
        //table.AddCell(new Paragraph(rdr[9].ToString(), mediumFont_a));



        //table.AddCell("");
        ////NEW  CONDITION
        //rdr.Close();
        ////END
        //conn.Close();
        //dc.Add(table);
        //dc.Close();
    }



    public void MergeFiles_NEW(string destinationFile, string[] sourceFiles)
    {
        try
        {
            int f = 0;
            // we create a reader for a certain document
            PdfReader reader = new PdfReader(sourceFiles[f]);
            // we retrieve the total number of pages
            int n = reader.NumberOfPages;
            Console.WriteLine("There are " + n + " pages in the original file.");
            // step 1: creation of a document-object
            Document document = new Document(reader.GetPageSizeWithRotation(1));
            // step 2: we create a writer that listens to the document
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(destinationFile, FileMode.Create));
            // step 3: we open the document
            document.Open();
            PdfContentByte cb = writer.DirectContent;
            PdfImportedPage page;
            int rotation;
            // step 4: we add content
            while (f < sourceFiles.Length)
            {
                int i = 0;
                while (i < n)
                {
                    i++;
                    document.SetPageSize(reader.GetPageSizeWithRotation(i));
                    document.NewPage();
                    page = writer.GetImportedPage(reader, i);
                    rotation = reader.GetPageRotation(i);
                    if (rotation == 90 || rotation == 270)
                    {
                        cb.AddTemplate(page, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(i).Height);
                    }
                    else
                    {
                        cb.AddTemplate(page, 1f, 0, 0, 1f, 0, 0);
                    }
                    Console.WriteLine("Processed page " + i);
                }
                f++;
                if (f < sourceFiles.Length)
                {
                    reader = new PdfReader(sourceFiles[f]);
                    // we retrieve the total number of pages
                    n = reader.NumberOfPages;
                    //Console.WriteLine("There are " + n + " pages in the original file.");
                }
            }
            // step 5: we close the document
            document.Close();
        }
        catch (Exception e)
        {
            Master.ShowError(e.Message);
        }
    }


    public void MergeFiles(string destinationFile, string[] sourceFiles)
    {
        try
        {
            int f = 0;
            // we create a reader for a certain document
            PdfReader reader = new PdfReader(sourceFiles[f]);
            // we retrieve the total number of pages
            int n = reader.NumberOfPages;
            Console.WriteLine("There are " + n + " pages in the original file.");
            // step 1: creation of a document-object
            Document document = new Document(reader.GetPageSizeWithRotation(1));
            // step 2: we create a writer that listens to the document
            PdfWriter writer = PdfWriter.GetInstance(document, new FileStream(destinationFile, FileMode.Create));
            // step 3: we open the document
            document.Open();
            PdfContentByte cb = writer.DirectContent;
            PdfImportedPage page;
            int rotation;
            // step 4: we add content
            while (f < sourceFiles.Length)
            {
                int i = 0;
                while (i < n)
                {
                    i++;
                    document.SetPageSize(reader.GetPageSizeWithRotation(i));
                    document.NewPage();
                    page = writer.GetImportedPage(reader, i);
                    rotation = reader.GetPageRotation(i);
                    if (rotation == 90 || rotation == 270)
                    {
                        cb.AddTemplate(page, 0, -1f, 1f, 0, 0, reader.GetPageSizeWithRotation(i).Height);
                    }
                    else
                    {
                        cb.AddTemplate(page, 1f, 0, 0, 1f, 0, 0);
                    }
                    Console.WriteLine("Processed page " + i);
                }
                f++;
                if (f < sourceFiles.Length)
                {
                    reader = new PdfReader(sourceFiles[f]);
                    // we retrieve the total number of pages
                    n = reader.NumberOfPages;
                    //Console.WriteLine("There are " + n + " pages in the original file.");
                }
            }
            // step 5: we close the document
            document.Close();
        }
        catch (Exception e)
        {
            Master.ShowError(e.Message);
        }
    }




    protected void CheckIsomeList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckSpoolList.SelectedIndex = -1;
        CheckJointList.SelectedIndex = -1;
        CheckMaterialList.SelectedIndex = -1;

        string exp_type = CheckIsomeList.SelectedValue;
        if (exp_type == "PIPISO" || exp_type == "PIPISOHC" || exp_type == "PIPISOAB")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Isometric.xlsx";
            sample_table_name = "BULK_ISOMETRIC_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "PIPSPL" || exp_type == "PIPSPLAB" || exp_type == "SPL_HS" || exp_type == "FLUSHING" || exp_type == "SPL_GALV" || exp_type == "PAINTING" || exp_type == "PICKLING")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "FITUP" || exp_type == "WELDING" || exp_type == "DIM_CHECK" || exp_type == "RT" || exp_type == "PT" || exp_type == "MT" ||
               exp_type == "UT" || exp_type == "PWHT" || exp_type == "PMI" || exp_type == "HT" || exp_type == "FT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Joints_Report.xlsx";
            sample_table_name = "BULK_JOINT_REP_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "MTC" || exp_type == "MRIR" || exp_type == "ESD"  || exp_type == "PO")
            //|| exp_type == "DAILYFITUP" || exp_type == "DAILYWELD"
            //|| exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Files.xlsx";
            sample_table_name = "BULK_DOCUMENT_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if(exp_type == "DAILYFITUP" || exp_type == "DAILYWELD")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Fab_Sample_Files.xlsx";
            sample_table_name = "BULK_FAB_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if(exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_NDT_Files.xlsx";
            sample_table_name = "BULK_NDT_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "PIPSPLHS"  || exp_type == "PIPSPLHSHYDRO")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if(exp_type == "SPL_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }
    }
    protected void CheckSpoolList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckIsomeList.SelectedIndex = -1;
        CheckJointList.SelectedIndex = -1;
        CheckMaterialList.SelectedIndex = -1;


        string exp_type = CheckSpoolList.SelectedValue;
        if (exp_type == "PIPISO" || exp_type == "PIPISOHC" || exp_type == "PIPISOAB")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Isometric.xlsx";
            sample_table_name = "BULK_ISOMETRIC_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "PIPSPL" || exp_type == "PIPSPLAB" || exp_type == "SPL_HS" || exp_type == "FLUSHING" || exp_type == "SPL_GALV" || exp_type == "PAINTING" || exp_type == "PICKLING")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "FITUP" || exp_type == "WELDING" || exp_type == "DIM_CHECK" || exp_type == "RT" || exp_type == "PT" || exp_type == "MT" ||
               exp_type == "UT" || exp_type == "PWHT" || exp_type == "PMI" || exp_type == "HT" || exp_type == "FT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Joints_Report.xlsx";
            sample_table_name = "BULK_JOINT_REP_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "MTC" || exp_type == "MRIR" || exp_type == "ESD" || exp_type == "PO")
            //|| exp_type == "DAILYFITUP" || exp_type == "DAILYWELD"
            //|| exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Files.xlsx";
            sample_table_name = "BULK_DOCUMENT_DOWNLOAD";
            sample_export_type = exp_type;
        }


        else if (exp_type == "DAILYFITUP" || exp_type == "DAILYWELD")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Fab_Sample_Files.xlsx";
            sample_table_name = "BULK_FAB_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_NDT_Files.xlsx";
            sample_table_name = "BULK_NDT_DOWNLOAD";
            sample_export_type = exp_type;
        }


        else if (exp_type == "PIPSPLHS" || exp_type == "PIPSPLHSHYDRO")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }

    }

    protected void CheckJointList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckIsomeList.SelectedIndex = -1;
        CheckSpoolList.SelectedIndex = -1;
        CheckMaterialList.SelectedIndex = -1;

        string exp_type = CheckJointList.SelectedValue;
        if (exp_type == "PIPISO" || exp_type == "PIPISOHC" || exp_type == "PIPISOAB")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Isometric.xlsx";
            sample_table_name = "BULK_ISOMETRIC_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "PIPSPL" || exp_type == "PIPSPLAB" || exp_type == "SPL_HS" || exp_type == "FLUSHING" || exp_type == "SPL_GALV" || exp_type == "PAINTING" || exp_type == "PICKLING")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "FITUP" || exp_type == "WELDING" || exp_type == "DIM_CHECK" || exp_type == "RT" || exp_type == "PT" || exp_type == "MT" ||
               exp_type == "UT" || exp_type == "PWHT" || exp_type == "PMI" || exp_type == "HT" || exp_type == "FT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Joints_Report.xlsx";
            sample_table_name = "BULK_JOINT_REP_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "MTC" || exp_type == "MRIR" || exp_type == "ESD" || exp_type == "PO")
            //|| exp_type == "DAILYFITUP" || exp_type == "DAILYWELD"
            //|| exp_type == "DAILYNDT")

        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Files.xlsx";
            sample_table_name = "BULK_DOCUMENT_DOWNLOAD";
            sample_export_type = exp_type;
        }


        else if (exp_type == "DAILYFITUP" || exp_type == "DAILYWELD")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Fab_Sample_Files.xlsx";
            sample_table_name = "BULK_FAB_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_NDT_Files.xlsx";
            sample_table_name = "BULK_NDT_DOWNLOAD";
            sample_export_type = exp_type;
        }


        else if (exp_type == "PIPSPLHS" || exp_type == "PIPSPLHSHYDRO")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }



    }

    protected void CheckMaterialList_SelectedIndexChanged(object sender, EventArgs e)
    {
        CheckIsomeList.SelectedIndex = -1;
        CheckSpoolList.SelectedIndex = -1;
        CheckJointList.SelectedIndex = -1;

        string exp_type = CheckMaterialList.SelectedValue;
        if (exp_type == "PIPISO" || exp_type == "PIPISOHC" || exp_type == "PIPISOAB")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Isometric.xlsx";
            sample_table_name = "BULK_ISOMETRIC_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "PIPSPL" || exp_type == "PIPSPLAB" || exp_type == "SPL_HS" || exp_type == "FLUSHING" || exp_type == "SPL_GALV" || exp_type == "PAINTING" || exp_type == "PICKLING")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "FITUP" || exp_type == "WELDING" || exp_type == "DIM_CHECK" || exp_type == "RT" || exp_type == "PT" || exp_type == "MT" ||
               exp_type == "UT" || exp_type == "PWHT" || exp_type == "PMI" || exp_type == "HT" || exp_type == "FT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Joints_Report.xlsx";
            sample_table_name = "BULK_JOINT_REP_DOWNLOAD";
            sample_export_type = exp_type;
        }
        else if (exp_type == "MTC" || exp_type == "MRIR" || exp_type == "ESD" || exp_type == "PO")
            //|| exp_type == "DAILYFITUP" || exp_type == "DAILYWELD"
            //|| exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Files.xlsx";
            sample_table_name = "BULK_DOCUMENT_DOWNLOAD";
            sample_export_type = exp_type;
        }



        else if (exp_type == "DAILYFITUP" || exp_type == "DAILYWELD")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Fab_Sample_Files.xlsx";
            sample_table_name = "BULK_FAB_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "DAILYNDT")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_NDT_Files.xlsx";
            sample_table_name = "BULK_NDT_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "PIPSPLHS" || exp_type == "PIPSPLHSHYDRO")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SPL_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_Barcode_Spool.xlsx";
            sample_table_name = "BULK_SPOOL_BARCODE_DOWNLOAD";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_BARCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }

        else if (exp_type == "SFR_QRCODE")
        {
            linkSample.NavigateUrl = "~/Export_Format/Bulk_SFR_Barcode.xlsx";
            sample_table_name = "BULK_BARCODE_SFR";
            sample_export_type = exp_type;
        }




    }

    protected string exportType()
    {
        if (CheckIsomeList.SelectedIndex != -1)
            return CheckIsomeList.SelectedValue;
        else if (CheckSpoolList.SelectedIndex != -1)
            return CheckSpoolList.SelectedValue;
        else if (CheckJointList.SelectedIndex != -1)
            return CheckJointList.SelectedValue;
        else
            return CheckMaterialList.SelectedValue;
    }


    protected void btnDownload_Click(object sender, EventArgs e)
    {
        if (CheckIsomeList.SelectedItem == null && CheckSpoolList.SelectedItem == null && CheckJointList.SelectedItem == null && CheckMaterialList.SelectedItem == null)
        {
            lblMessage.Text = "Please select an item !";
            return;
        }
        string tablename = string.Empty;
        string exp_type = exportType();
        string export = string.Empty;


        if (exp_type == "PIPISO" || exp_type == "PIPISOHC" || exp_type == "PIPISOAB")
        {
            tablename = "BULK_ISOMETRIC_DOWNLOAD";
            export = "ISO_SPOOLGEN";
        }
        else if (exp_type == "PIPSPL" || exp_type == "PIPSPLAB" || exp_type == "SPL_HS" || exp_type == "FLUSHING" || exp_type == "SPL_GALV" || exp_type == "PAINTING" || exp_type == "PICKLING")
        {
            tablename = "BULK_SPOOL_DOWNLOAD";
            export = "PIPSPL";
        }
        else if (exp_type == "PIPSPLHS"  ||  exp_type == "PIPSPLHSHYDRO")
        {
            tablename = "BULK_SPOOL_DOWNLOAD";

            //Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=200.1");
            //export = "PIPSPL";
        }
        else if (exp_type == "FITUP" || exp_type == "WELDING" || exp_type == "DIM_CHECK" || exp_type == "RT" || exp_type == "PT" || exp_type == "MT" ||
                exp_type == "UT" || exp_type == "PWHT" || exp_type == "PMI" || exp_type == "HT" || exp_type == "FT")
        {
            tablename = "BULK_JOINT_REP_DOWNLOAD";
            export = exp_type;
        }
        else if (exp_type == "MTC" || exp_type == "MRIR" || exp_type == "ESD" || exp_type == "PO")
            //|| exp_type == "DAILYFITUP" || exp_type == "DAILYWELD"
            //|| exp_type == "DAILYNDT")
        {
            //linkSample.NavigateUrl = "~/Export_Format/Bulk_Isometric.xlsx";
            tablename = "BULK_DOCUMENT_DOWNLOAD";
            export = exp_type;
        }

        else if (exp_type == "DAILYFITUP" || exp_type == "DAILYWELD")
        {

            tablename = "BULK_FAB_DOWNLOAD";
            export = exp_type;
        }

        else if (exp_type == "DAILYNDT")
        {

            tablename = "BULK_NDT_DOWNLOAD";
            export = exp_type;
        }


        else if (exp_type == "SPL_BARCODE")
        {
            
            tablename = "BULK_SPOOL_BARCODE_DOWNLOAD";
            export = exp_type;
        }

        else if (exp_type == "SPL_QRCODE")
        {

            tablename = "BULK_SPOOL_BARCODE_DOWNLOAD";
            export = exp_type;
        }

        else if (exp_type == "SFR_BARCODE")
        {
            
            tablename = "BULK_BARCODE_SFR";
            export = exp_type;
        }

        else if (exp_type == "SFR_QRCODE")
        {

            tablename = "BULK_BARCODE_SFR";
            export = exp_type;
        }


        string sourceView = string.Empty;

       
            string sql = "DELETE FROM " + tablename + " WHERE USER_NAME = '" + Session["USER_NAME"] + "'";
            WebTools.ExeSql(sql);
            sql = string.Empty;
        

        ImportData(tablename, exp_type);

        if (exp_type == "PIPSPLHS")
        {
            Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=200.1");
        }

        if(exp_type == "PIPSPLHSHYDRO")
        {
            Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=200.3");
        }

        if(exp_type == "SPL_BARCODE")
        {

            try
            {

                DataTable dt = new DataTable();

                dt = ((DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty)).Table;

                string[] Files = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles");
                foreach (string file in Files)
                {
                    System.IO.File.Delete(file);
                }

                if (dt.Rows.Count >= 1000)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "000" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 2)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 3)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 4)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                if ((dt.Rows.Count) >= 100 && (dt.Rows.Count) < 1000)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {

                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 2)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 3)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                if ((dt.Rows.Count) < 100)
                {
                    foreach (DataRow dr in dt.Rows)
                    {

                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        else
                        {
                            createTable("BarcodeFiles", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                string path_100 = HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles";

                // string path = "D://PDF_DIR//2014_RABIGH" + "//" + "BarcodeFiles";

                string[] filenames = Directory.GetFiles(path_100);

                MergeFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles1" + "/" + "MultipleBarcode" + ".pdf", filenames);

                string[] Filenames = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles1");

                using (ZipFile zip = new ZipFile())
                {
                    zip.AddFiles(Filenames, "files");
                    zip.Save(Server.MapPath("~/Zip_Folder/barcode1.zip"));
                }

                Response.Redirect("~/Zip_Folder/barcode1.zip");
            }
            catch (Exception ex)
            {
                Master.ShowMessage(ex.Message);
            }
      }

        if (exp_type == "SPL_QRCODE")
        {

            //try
            //{

            DataTable dt = new DataTable();

            dt = ((DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty)).Table;

            string[] Files = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles");
            foreach (string file in Files)
            {
                System.IO.File.Delete(file);
            }

            if (dt.Rows.Count >= 1000)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["ITEM_ID"].ToString().Length == 1)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "000" + dr["ITEM_ID"].ToString());
                    }

                    if (dr["ITEM_ID"].ToString().Length == 2)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                    }

                    if (dr["ITEM_ID"].ToString().Length == 3)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                    }

                    if (dr["ITEM_ID"].ToString().Length == 4)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                    }
                }
            }

            if ((dt.Rows.Count) >= 100 && (dt.Rows.Count) < 1000)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["ITEM_ID"].ToString().Length == 1)
                    {

                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                    }

                    if (dr["ITEM_ID"].ToString().Length == 2)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                    }

                    if (dr["ITEM_ID"].ToString().Length == 3)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                    }
                }
            }

            if ((dt.Rows.Count) < 100)
            {
                foreach (DataRow dr in dt.Rows)
                {

                    if (dr["ITEM_ID"].ToString().Length == 1)
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                    }

                    else
                    {
                        createTable_QR("QRcodeFiles", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                    }
                }
            }

            string path_100 = HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles";

            // string path = "D://PDF_DIR//2014_RABIGH" + "//" + "BarcodeFiles";

            string[] filenames = Directory.GetFiles(path_100);

            MergeFiles(HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles1" + "/" + "MultipleBarcode" + ".pdf", filenames);

            string[] Filenames = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles1");

            using (ZipFile zip = new ZipFile())
            {
                zip.AddFiles(Filenames, "files");
                zip.Save(Server.MapPath("~/Zip_Folder/QRcode1.zip"));
            }

            Response.Redirect("~/Zip_Folder/QRcode1.zip");
            //}
            //catch (Exception ex)
            //{
            //    Master.ShowMessage(ex.Message);
            //}
        }

        if (exp_type == "SFR_BARCODE")
        {

            ////try
            ////{

                DataTable dt = new DataTable();

                dt = ((DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty)).Table;

                string[] Files = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles1");
                foreach (string file in Files)
                {
                    System.IO.File.Delete(file);
                }

                if (dt.Rows.Count >= 1000)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "000" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 2)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 3)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 4)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                if ((dt.Rows.Count) >= 100 && (dt.Rows.Count) < 1000)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {

                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 2)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 3)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                if ((dt.Rows.Count) < 100)
                {
                    foreach (DataRow dr in dt.Rows)
                    {

                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        else
                        {
                            createTable_NEW("BarcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                string path_100 = HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles1";
                // string path = "D://PDF_DIR//2014_RABIGH" + "//" + "BarcodeFiles";
                string[] filenames = Directory.GetFiles(path_100);
                MergeFiles_NEW(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles2" + "/" + "MultipleBarcode2" + ".pdf", filenames);
                string[] Filenames = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "BarcodeFiles2");
                using (ZipFile zip = new ZipFile())
                {
                    zip.AddFiles(Filenames, "files");
                    zip.Save(Server.MapPath("~/Zip_Folder/barcode2.zip"));
                }

                Response.Redirect("~/Zip_Folder/barcode2.zip");
            ////}
            ////catch (Exception ex)
            ////{
            ////    Master.ShowMessage(ex.Message);
            ////}
        }

        if (exp_type == "SFR_QRCODE")
        {

            try
            {

                DataTable dt = new DataTable();

                dt = ((DataView)SqlDataSource2.Select(DataSourceSelectArguments.Empty)).Table;

                string[] Files = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles1");
                foreach (string file in Files)
                {
                    System.IO.File.Delete(file);
                }

                if (dt.Rows.Count >= 1000)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "000" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 2)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 3)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 4)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                if ((dt.Rows.Count) >= 100 && (dt.Rows.Count) < 1000)
                {
                    foreach (DataRow dr in dt.Rows)
                    {
                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {

                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "00" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 2)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        if (dr["ITEM_ID"].ToString().Length == 3)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                if ((dt.Rows.Count) < 100)
                {
                    foreach (DataRow dr in dt.Rows)
                    {

                        if (dr["ITEM_ID"].ToString().Length == 1)
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), "0" + dr["ITEM_ID"].ToString());
                        }

                        else
                        {
                            createTable_NEW_QR("QRcodeFiles1", int.Parse(dr["SPL_ID"].ToString()), dr["ITEM_ID"].ToString());
                        }
                    }
                }

                string path_100 = HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles1";
                // string path = "D://PDF_DIR//2014_RABIGH" + "//" + "BarcodeFiles";
                string[] filenames = Directory.GetFiles(path_100);
                MergeFiles_NEW(HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles2" + "/" + "MultipleBarcode2" + ".pdf", filenames);
                string[] Filenames = Directory.GetFiles(HttpContext.Current.Request.PhysicalApplicationPath + "QRcodeFiles2");
                using (ZipFile zip = new ZipFile())
                {
                    zip.AddFiles(Filenames, "files");
                    zip.Save(Server.MapPath("~/Zip_Folder/QRcode2.zip"));
                }

                Response.Redirect("~/Zip_Folder/QRcode2.zip");
            }
            catch (Exception ex)
            {
                Master.ShowMessage(ex.Message);
            }
        }




        if (exp_type == "DAILYFITUP")
        {
            //Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=501");


            string format = "EXCELOPENXML";


            VIEW_JOINT_FITUP_NEW_BILLTableAdapter welder_lot = new VIEW_JOINT_FITUP_NEW_BILLTableAdapter();
            ReportDataSource WelderLotDS = new ReportDataSource("dsSpoolReportsA_VIEW_JOINT_FITUP_NEW_BILL", welder_lot.GetData(Session["USER_NAME"].ToString()) as DataTable);

            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = ProcessingMode.Local;
            viewer.LocalReport.ReportPath = "BasicReports\\Spool\\Daily_Fitup_Report.rdlc";
            viewer.LocalReport.DataSources.Add(WelderLotDS);
            viewer.LocalReport.EnableExternalImages = true;

            byte[] bytes = viewer.LocalReport.Render(format, null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.

           

            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = mimeType;
            string filename = "Daily_Fitup_Report_" + DateTime.Now.ToString("dd-MMM-yyyy") + ".";
            Response.AddHeader("content-disposition", "attachment; filename=" + filename + extension);
            Response.BinaryWrite(bytes); // create the file 
            Response.Flush(); // send it to the client to download
            Response.End();

        }
        //|| exp_type == "DAILYWELD"
        //|| exp_type == "DAILYNDT")

        if (exp_type == "DAILYWELD")
        {
            //Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=501");


            string format = "EXCELOPENXML";


            VIEW_JOINT_WELD_NEW_BILLTableAdapter welder_lot = new VIEW_JOINT_WELD_NEW_BILLTableAdapter();
            ReportDataSource WelderLotDS = new ReportDataSource("dsSpoolReportsA_VIEW_JOINT_WELD_NEW_BILL", 
                welder_lot.GetData(Session["USER_NAME"].ToString()) as DataTable);

            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = ProcessingMode.Local;
            viewer.LocalReport.ReportPath = "BasicReports\\Spool\\Daily_Weld_Report.rdlc";
            viewer.LocalReport.DataSources.Add(WelderLotDS);
            viewer.LocalReport.EnableExternalImages = true;

            byte[] bytes = viewer.LocalReport.Render(format, null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.

            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = mimeType;
            string filename = "Daily_Weld_Report_" + DateTime.Now.ToString("dd-MMM-yyyy") + ".";
            Response.AddHeader("content-disposition", "attachment; filename=" + filename + extension);
            Response.BinaryWrite(bytes); // create the file 
            Response.Flush(); // send it to the client to download
            Response.End();

        }




        if (exp_type == "DAILYNDT")
        {
            //Response.Redirect("~/BasicReports/ReportViewer.aspx?ReportID=501");


            string format = "EXCELOPENXML";


            VIEW_JOINT_NDT_NEW_BILLTableAdapter welder_lot = new VIEW_JOINT_NDT_NEW_BILLTableAdapter();
            ReportDataSource WelderLotDS = new ReportDataSource("dsSpoolReportsA_VIEW_JOINT_NDT_NEW_BILL", welder_lot.GetData(Session["USER_NAME"].ToString()) as DataTable);

            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            ReportViewer viewer = new ReportViewer();
            viewer.ProcessingMode = ProcessingMode.Local;
            viewer.LocalReport.ReportPath = "BasicReports\\Spool\\Daily_NDT_Report.rdlc";
            viewer.LocalReport.DataSources.Add(WelderLotDS);
            viewer.LocalReport.EnableExternalImages = true;

            byte[] bytes = viewer.LocalReport.Render(format, null, out mimeType, out encoding, out extension, out streamIds, out warnings);

            // Now that you have all the bytes representing the PDF report, buffer it and send it to the client.

            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = mimeType;
            string filename = "Daily_NDT_Report_" + DateTime.Now.ToString("dd-MMM-yyyy") + ".";
            Response.AddHeader("content-disposition", "attachment; filename=" + filename + extension);
            Response.BinaryWrite(bytes); // create the file 
            Response.Flush(); // send it to the client to download
            Response.End();

        }



        string path = WebTools.SessionDataPath();
        string zip_file_path = path + exp_type + ".zip";

        //ZipFile
        using (ZipFile zip = new ZipFile())
        {
            CollectPDFs(zip, exp_type);
            zip.Save(zip_file_path);
        }

        var updateFile = new FileInfo(zip_file_path);
        Response.ContentType = "application/octet-stream";
        Response.AddHeader("content-disposition", "attachment;filename=\"" + Path.GetFileName(updateFile.FullName) + "\"");
        Response.AddHeader("content-length", updateFile.Length.ToString());
        Response.TransmitFile(updateFile.FullName);
        Response.Flush();
    }

    protected void ImportData(string tablename, string exp_type)
    {

        //tablename = "PIP_BULK_EXPORT_FILE";

        if (RadAsyncUpload1.UploadedFiles.Count == 0) return;

        string proj_id = Session["PROJECT_ID"].ToString();
        string FileName = Path.GetFileName(RadAsyncUpload1.UploadedFiles[0].FileName);
        string Extension = Path.GetExtension(RadAsyncUpload1.UploadedFiles[0].FileName);
        string FolderPath = WebTools.SessionDataPath();
        string sql = "DELETE FROM " + tablename + " WHERE USER_NAME = '" + Session["USER_NAME"] + "'";
        try
        {

            //WebTools.ExeSql(sql);
            string FilePath = FolderPath + FileName;
            RadAsyncUpload1.UploadedFiles[0].SaveAs(FilePath);

            FileStream stream = new FileStream(FilePath, FileMode.Open, FileAccess.Read);
            DataTable dt = new DataTable();
            dt = ExcelImport.xlsxToDT2(stream);

            dt.Columns.Add("USER_NAME", typeof(System.String));
            dt.Columns.Add("EXPORT_OPTION", typeof(System.String));

            foreach (DataRow row in dt.Rows)
            {
                row["USER_NAME"] = Session["USER_NAME"].ToString();
                row["EXPORT_OPTION"] = exp_type;
            }

            ExcelImport.ImportDataTable(dt, tablename, "", "PROJECT_ID", proj_id);

    }
        catch (Exception ex)
        {
            Master.ShowError(ex.Message);
        }
    }

    private void CollectPDFs(ZipFile zip_file, string dirObject)
    {
        //string path = WebTools.SessionDataPath();
        string sql = "";
        string FileName = "";
        //string folderName = WebTools.GetExpr("folder_name", "dir_Objects", " where dir_obj='" + dirObject + "'");
        string folderPath = WebTools.GetExpr("path", "dir_objects", " folder_name='" + dirObject + "'");
        string filePath = string.Empty;
        using (OracleConnection conn = WebTools.GetIpmsConnection())
        {
            //Isometric
            sql = "SELECT * FROM VIEW_BULK_PDF_EXPORT WHERE USER_NAME='" + Session["USER_NAME"].ToString() + "' AND EXPORT_OPTION = '" + dirObject + "'";
            using (OracleCommand cmd = new OracleCommand(sql, conn))
            {
                using (OracleDataReader dataReader = cmd.ExecuteReader())
                {
                    while (dataReader.Read())
                    {
                        FileName = WebTools.SessionDataPath() + dataReader["PDF_FILE_NAME"];

                        if (File.Exists(FileName))
                            File.Delete(FileName);

                        if (File.Exists(folderPath + dataReader["PDF_FILE_NAME"]))
                        {
                            zip_file.AddFile(folderPath + dataReader["PDF_FILE_NAME"]);
                        }

                    }
                }//OracleDataReader1
            }//OracleCommand1            
        }//OracleConnection
    }
}




