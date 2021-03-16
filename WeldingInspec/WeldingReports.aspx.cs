using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dsWeldingATableAdapters;
using System.Data;
using Ionic.Zip;
using Telerik.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OracleClient;

public partial class WeldingInspec_WeldingReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void HeaderMenu_ItemClick(object sender, Telerik.Web.UI.RadMenuEventArgs e)
    {
        string myMenu = HeaderMenu.SelectedValue.ToString();
        switch (myMenu)
        {
            case "back":
                {
                    Response.Redirect("~/WeldingInspec/PipingDFWR.aspx");
                }
                break;
        }
    }

    protected void txtWeldRepNo_TextChanged(object sender, EventArgs e)
    {
        txtWeldRepNo.Text = txtWeldRepNo.Text.Trim().ToUpper();
        ddWeldRepNo.Items.Clear();
        ddWeldRepNo.Items.Add(new Telerik.Web.UI.RadComboBoxItem("Select any Report", string.Empty));
        ddWeldRepNo.DataBind();
    }

    protected void btnPreview_Click(object sender, EventArgs e)
    {
        if (rdoOptions.SelectedValue.Equals("-1"))
        {
            lblMessage.Text = "<font color='red'>" + "Please select a either Report Number or Date Range !" + "</font>";
            return;
        }

        //Download rdlc as pdf
        string filename = string.Empty;
        string selectedOption = rdoOptions.SelectedValue;

        switch (selectedOption)
        {
            case "individual":
                filename = ddWeldRepNo.SelectedValue;
                ExportPDF1(filename, null, null, null, null, null, null, null,null,null, filename,"individual");
                return;
                break;
            case "entrydate":
                if (txtEntryFromDate.SelectedDate == null || txtEntryToDate.SelectedDate == null)
                {
                    lblMessage.Text = "<font color='red'>" + "Please select both date range !" + "</font>";
                    return;
                }

                //  for (DateTime? dt = txtEntryFromDate.SelectedDate; dt <= txtEntryToDate.SelectedDate;)
                //  {
                filename = "AMG-DWR";// + DateTime.Parse(dt.ToString()).ToString("yyMMdd");
                                      //ExportPDF(decimal.Parse(cboSubcon.SelectedValue), DateTime.Parse(dt.ToString()).ToString("dd-MMM-yyyy"), DateTime.Parse(dt.ToString()).ToString("dd-MMM-yyyy"), filename, Session.SessionID, selectedOption);
                ExportPDF1(null, DateTime.Parse(txtEntryFromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), DateTime.Parse(txtEntryToDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), null, null, null, null, null,null,null, filename,"entrydate");
                return;
                //  dt = DateTime.Parse(dt.ToString()).AddDays(1);
                //  }
                break;
            case "welddate":
                if (txtWeldFromDate.SelectedDate == null || txtWeldToDate.SelectedDate == null)
                {
                    lblMessage.Text = "<font color='red'>" + "Please select both date range !" + "</font>";
                    return;
                }

                // for (DateTime? dt = txtWeldFromDate.SelectedDate; dt <= txtWeldToDate.SelectedDate;)
                // {
                filename = "AMG-DWR";// + DateTime.Parse(dt.ToString()).ToString("yyMMdd");
                ExportPDF1(null, null, null, DateTime.Parse(txtWeldFromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), DateTime.Parse(txtWeldToDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), null, null, null,null,null, filename,"welddate");

                //  dt = DateTime.Parse(dt.ToString()).AddDays(1);
                // }
                return;
                break;
            case "fitupentry":
                if (txtInspFromDate.SelectedDate == null || txtInspToDate.SelectedDate == null)
                {
                    lblMessage.Text = "<font color='red'>" + "Please select both date range !" + "</font>";
                    return;
                }

                //    for (DateTime? dt = txtInspFromDate.SelectedDate; dt <= txtInspToDate.SelectedDate;)
                //  {
                filename = "AMG-DWR";// + DateTime.Parse(dt.ToString()).ToString("yyMMdd");
                ExportPDF1(null, null, null, null, null, DateTime.Parse(txtInspFromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), DateTime.Parse(txtInspToDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), null,null,null, filename, "fitupentry");
                //     dt = DateTime.Parse(dt.ToString()).AddDays(1);
                //  }
                break;
            case "fitupdate":
                if (txtFitupFromDate.SelectedDate == null || txtFitupToDate.SelectedDate == null)
                {
                    lblMessage.Text = "<font color='red'>" + "Please select both date range !" + "</font>";
                    return;
                }

                //    for (DateTime? dt = txtInspFromDate.SelectedDate; dt <= txtInspToDate.SelectedDate;)
                //  {
                filename = "AMG-DWR";// + DateTime.Parse(dt.ToString()).ToString("yyMMdd");
                ExportPDF1(null, null, null, null, null, null, null, null, DateTime.Parse(txtFitupFromDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), DateTime.Parse(txtFitupToDate.SelectedDate.ToString()).ToString("dd-MMM-yyyy"), filename, "fitupdate");
                //     dt = DateTime.Parse(dt.ToString()).AddDays(1);
                //  }
                break;
            case "isometric":
                if (rcbisoList.CheckedItems.Count < 1)
                {
                    lblMessage.Text = "<font color='red'>" + "Select Isometric" + "</font>";
                    return;
                }

                string iso_list = "";

                foreach (RadComboBoxItem item in rcbisoList.CheckedItems)
                {
                    iso_list += item.Value + ",";
                }
                if (iso_list.Length > 1)
                    iso_list = iso_list.Substring(0, iso_list.Length - 1);
                else
                    iso_list = "";

                //for (DateTime? dt = txtInspFromDate.SelectedDate; dt <= txtInspToDate.SelectedDate;)
                //{
                filename = "AMG-DWR-";// + DateTime.Parse(dt.ToString()).ToString("yyMMdd");
                ExportPDF1(null, null, null, null, null, null, null, iso_list,null,null, filename,"isometric");
                return;
                //  dt = DateTime.Parse(dt.ToString()).AddDays(1);
                //}
                break;
        }

        //string flag = string.Empty;
        //ZipFile zip = new ZipFile();

        //if (!Directory.Exists(@"C:\Temp"))
        //    Directory.CreateDirectory(@"C:\Temp");

        //if (!Directory.Exists(@"C:\Temp\" + Session.SessionID))
        //    Directory.CreateDirectory(@"C:\Temp\" + Session.SessionID);

        //if (!Directory.Exists(Server.MapPath("~/PIPING_WICS/temp/" + Session.SessionID)))
        //    Directory.CreateDirectory(Server.MapPath("~/PIPING_WICS/temp/" + Session.SessionID));
        //string[] filelist1 = Directory.GetFiles(Server.MapPath("~/PIPING_WICS/temp/" + Session.SessionID));
        //for (int i = 0; i < filelist1.Length; i++)
        //{
        //    File.Move(filelist1[i], @"C:\Temp\" + Session.SessionID + "\\" + Path.GetFileName(filelist1[i]));
        //}


        //string[] filelist = Directory.GetFiles(@"C:\Temp\" + Session.SessionID);
        //for (int i = 0; i < filelist.Length; i++)
        //{
        //    zip.AddFile(filelist[i]);
        //}

        //zip.Save(Server.MapPath("~/Zip_Folder/WeldingReports.zip"));

        //for (int i = 0; i < filelist.Length; i++)
        //{
        //    File.Delete(filelist[i]);
        //}
        //Directory.Delete(Server.MapPath("~/PIPING_WICS/temp/" + Session.SessionID));
        //Directory.Delete(@"C:\Temp\" + Session.SessionID);
        //Response.Redirect("~/Zip_Folder/WeldingReports.zip");
        //Response.End();
    }
    //REP,ENTRYDATE1,ENTRYDATE2,WELDDATE1,WELDDATE2,INSPDATE1,INSPDATE2,ISOLIST,,FITUP_DATE1,FITUP_DATE2,FILMNAME,REPORT_TYPE
    public string ExportPDF1(string Arg1, string Arg2, string Arg3, string Arg4, string Arg5, string Arg6, string Arg7, string Arg8, string Arg9, string Arg10, string filename,string report_type)
    {
        ReportViewer ReportViewer1 = new ReportViewer();
        ReportViewer1.LocalReport.EnableExternalImages = true;

        VIEW_WELDING_REPORTTableAdapter weld_rep_psjv = new VIEW_WELDING_REPORTTableAdapter();

        //ReportViewer1.LocalReport.ReportPath = "WeldingInspec\\Reports\\DailyWeldingReport_KOC.rdlc";
        if (report_type == "fitupentry" || report_type=="fitupdate")
        {
            ReportViewer1.LocalReport.ReportPath = "WeldingInspec\\Reports\\DailyFitupReport_STD.rdlc";
        }
        else
        {
            ReportViewer1.LocalReport.ReportPath = "WeldingInspec\\Reports\\DailyWeldingReport_STD.rdlc";
        }
        // ReportViewer1.LocalReport.ReportPath = "REPORTS\\DESIGN\\Dly_Weld_Insp_Rep.rdlc";
        if (!string.IsNullOrEmpty(Arg1))
        {
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                "dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetData(Arg1) as DataTable));
        }
        else if (Arg2 != null && Arg3 != null)
        {
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                "dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByEntry(DateTime.Parse(Arg2), DateTime.Parse(Arg3), decimal.Parse(cboSubcon.SelectedValue)) as DataTable));
        }
        else if (Arg4 != null && Arg5 != null)
        {
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                "dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByWeld(DateTime.Parse(Arg4), DateTime.Parse(Arg5), decimal.Parse(cboSubcon.SelectedValue)) as DataTable));
        }

        else if (Arg6 != null && Arg7 != null)
        {
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                "dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByFitupEntry(DateTime.Parse(Arg6), DateTime.Parse(Arg7), decimal.Parse(cboSubcon.SelectedValue)) as DataTable));
        }
        else if (Arg8 != null)
        {
            string query = "Select *From VIEW_WELDING_REPORT WHERE ISO_ID IN (" + Arg8 + ") AND SUB_CON_ID=" + decimal.Parse(cboSubcon.SelectedValue);

            /////////////////////////////////////////////////////////////////////
            string connstr = ConfigurationManager.ConnectionStrings["ipmsConnectionString"].ConnectionString;
            DataTable dt = new DataTable();
            OracleConnection conn = new OracleConnection(connstr);
            conn.Open();
            OracleCommand cmd = new OracleCommand(query);
            cmd.CommandType = CommandType.Text;
            cmd.Connection = conn;
            using (OracleDataAdapter dataAdapter = new OracleDataAdapter(cmd))
            {
                dataAdapter.Fill(dt);
            }
            conn.Close();
            /////////////////////////////////////////////////////////////////////

            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                "dsWeldingA_VIEW_WELDING_REPORT", dt));
        }

        else if (Arg9 != null && Arg10 != null)
        {
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource(
                "dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByFitupDate(DateTime.Parse(Arg9), DateTime.Parse(Arg10), decimal.Parse(cboSubcon.SelectedValue)) as DataTable));
        }
        Warning[] warnings;
        string[] streamIds;
        string mimeType = string.Empty;
        string encoding = string.Empty;
        string extension = "pdf";


        //byte[] bytes = ReportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

        byte[] bytes = ReportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);

        //MemoryStream s = new MemoryStream(bytes);
        //s.Seek(0, SeekOrigin.Begin);
        //System.Web.HttpContext.Current.Response.BinaryWrite(bytes);
        //System.Web.HttpContext.Current.Response.Clear();



        System.Web.HttpContext.Current.Response.Buffer = true;
        System.Web.HttpContext.Current.Response.Clear();
        System.Web.HttpContext.Current.Response.ContentType = mimeType;
        System.Web.HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename= " + filename + "." + extension);
        //System.Web.HttpContext.Current.Response.OutputStream.Write(bytes, 0, bytes.Length); // create the file  
        Response.BinaryWrite(bytes);
        //System.Web.HttpContext.Current.Response.Flush(); // download  
        //Context.ApplicationInstance.CompleteRequest();

        return "0";
    }

    protected void cboSubcon_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddWeldRepNo.Items.Clear();
        ddWeldRepNo.Items.Add(new Telerik.Web.UI.RadComboBoxItem("Select any Report", string.Empty));
        ddWeldRepNo.DataBind();
        //lblMessage.Text = "You have selected " + cboSubcon.SelectedValue;
    }

    protected void rdoOptions_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedOption = rdoOptions.SelectedValue;
        switch (selectedOption)
        {
            case "individual":
                tblIndividual.Visible = true;
                tblEntryDate.Visible = false;
                tblWeldDate.Visible = false;
                tblInspDate.Visible = false;
                tblIsometric.Visible = false;
                tblFitupDate.Visible = false;
                break;
            case "entrydate":
                tblEntryDate.Visible = true;
                tblWeldDate.Visible = false;
                tblIndividual.Visible = false;
                tblInspDate.Visible = false;
                tblIsometric.Visible = false;
                tblFitupDate.Visible = false;
                break;
            case "welddate":
                tblWeldDate.Visible = true;
                tblEntryDate.Visible = false;
                tblIndividual.Visible = false;
                tblInspDate.Visible = false;
                tblIsometric.Visible = false;
                tblFitupDate.Visible = false;
                break;
            case "fitupentry":
                tblWeldDate.Visible = false;
                tblEntryDate.Visible = false;
                tblIndividual.Visible = false;
                tblInspDate.Visible = true;
                tblIsometric.Visible = false;
                tblFitupDate.Visible = false;
                break;
            case "fitupdate":
                tblWeldDate.Visible = false;
                tblEntryDate.Visible = false;
                tblIndividual.Visible = false;
                tblInspDate.Visible = false;
                tblIsometric.Visible = false;
                tblFitupDate.Visible = true;
                break;
            case "isometric":
                tblWeldDate.Visible = false;
                tblEntryDate.Visible = false;
                tblIndividual.Visible = false;
                tblInspDate.Visible = false;
                tblIsometric.Visible = true;
                tblFitupDate.Visible = false;
                break;

            default:
                tblWeldDate.Visible = false;
                tblEntryDate.Visible = false;
                tblIndividual.Visible = false;
                tblInspDate.Visible = false;
                tblFitupDate.Visible = false;
                break;
        }
    }

    public static string ExportPDF(decimal SubCon, string FromDate, string ToDate, string FileName, string SessionID, string option)
    {
        ReportViewer ReportViewer1 = new ReportViewer();
        ReportViewer1.LocalReport.EnableExternalImages = true;

        dsWeldingATableAdapters.VIEW_WELDING_REPORTTableAdapter weld_rep_psjv = new VIEW_WELDING_REPORTTableAdapter();
        
        ReportViewer1.LocalReport.ReportPath = "WeldingInspec\\Reports\\DailyWeldingReport_KOC.rdlc";

        switch (option)
        {
            case "individual":
                break;
            case "entrydate":
                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByEntry(DateTime.Parse(FromDate), DateTime.Parse(ToDate), SubCon) as DataTable));
                break;
            case "welddate":
                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByWeld(DateTime.Parse(FromDate), DateTime.Parse(ToDate), SubCon) as DataTable));
                break;
            //case "inspdate":
            //    ReportViewer1.LocalReport.ReportPath = "WeldingInspec\\Reports\\DailyWeldingReport_KOC.rdlc";
            //    ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsWeldingA_VIEW_WELDING_REPORT", weld_rep_psjv.GetDataByInsp(DateTime.Parse(FromDate), DateTime.Parse(ToDate), SubCon) as DataTable));
            //    break;
        }

        Warning[] warnings;
        string[] streamIds;
        string mimeType = string.Empty;
        string encoding = string.Empty;
        string extension = "pdf";
        FileStream stream;// = new FileStream();
        try
        {

            byte[] bytes = ReportViewer1.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
            if (!Directory.Exists(System.Web.HttpContext.Current.Server.MapPath("~/WeldingInspec/Temp/" + SessionID)))
                Directory.CreateDirectory(System.Web.HttpContext.Current.Server.MapPath("~/WeldingInspec/Temp/" + SessionID));

            stream = new FileStream(System.Web.HttpContext.Current.Server.MapPath("~/WeldingInspec/Temp/" + SessionID + "/" + FileName + ".pdf"), FileMode.Create, FileAccess.ReadWrite);
            stream.Write(bytes, 0, bytes.Length);

            stream.Close();
            stream.Dispose();
        }
        finally
        {
            //stream.Close();
            //stream.Dispose();
        }

        return "0";

    }

}