using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OracleClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.ExportInfrastructure;
using xls = Telerik.Web.UI.ExportInfrastructure;
using dsWeldingATableAdapters;

public partial class EntryPage_data : System.Web.UI.Page
{
    bool IsExporting = false;
    private xls.ExportStructure structure = new xls.ExportStructure();
    private xls.Table table = new xls.Table();
    private int row = 1;
    private int col = 1;
    private List<RadGrid> gridControlsFound = new List<RadGrid>();
    int user_id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            Master.HeadingMessage = "Entry Page";
            Master.AddModalPopup("~/Isome/IsomeAdd.aspx", ImageIsoButtonAdd.ClientID, 400, 630);
            Master.AddModalPopup("~/PipingNDT/NDE_RequestNew.aspx", ImageNdeNew.ClientID, 400, 700);



            string user_name = Session["USER_NAME"].ToString();
            if (user_name.Length > 0)
            {
                user_id = int.Parse(WebTools.GetExpr("USER_ID", "USERS", "USER_NAME='" + user_name + "'"));
            }

            if (WebTools.UserInRole("ADMIN"))
            {
                RadBulkImport.Visible = true;
            }
            else
            {
                RadBulkImport.Visible = false;
            }

            if (!WebTools.UserInRole("PIP_DCS_INSERT"))
            {
                ImageIsoButtonAdd.Visible = false;
                btnNewRevision.Visible = false;
                ImageSplButtonAdd.Visible = false;
                ImageJntButtonAdd.Visible = false;
            }

        }

    }


    private void FindGridsRecursive(Control control)
    {
        foreach (Control childControl in control.Controls)
        {
            if (childControl is RadGrid)
            {
                gridControlsFound.Add((RadGrid)childControl);
            }
            else
            {
                FindGridsRecursive(childControl);
            }
        }
    }





    protected void ImageIsoButtonDetails_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric to view details of Iso");
            ddlIsometric.Focus();
        }
        else
        {
            AddModalPopupButtonClick("~/Isome/IsomeDetail.aspx?ISO_ID=" + ddlIsometric.SelectedValue, ImageIsoButtonDetails.ClientID, 550, 600);

        }

    }
    protected void btnRevisions_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric to view revisions of Iso");
            ddlIsometric.Focus();
        }
        else
        {
            AddModalPopupButtonClick("~/Isome/IsomeRevision.aspx?ISO_ID=" + ddlIsometric.SelectedValue, btnRevisions.ClientID, 550, 600);
        }


    }
    protected void btnNewRevision_Click(object sender, EventArgs e)
    {
        if (!WebTools.UserInRole("PIP_DCS_INSERT"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric to create revision");
            ddlIsometric.Focus();
        }
        else
        {
            AddModalPopupButtonClick("~/Isome/IsomeRevisionNew.aspx?ISO_ID=" + ddlIsometric.SelectedValue, btnNewRevision.ClientID, 550, 600);

        }

    }
    protected void btnIsoPDF_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric to view PDF");
            ddlIsometric.Focus();
        }
        else
        {
            AddModalPopupButtonClick("~/Isome/ShowPDF.aspx?ISO_ID=" + ddlIsometric.SelectedValue, btnIsoPDF.ClientID, 550, 450);

        }
    }



    protected void ImageSplButtonAdd_Click(object sender, ImageClickEventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            ImageSplButtonAdd.Enabled = false;
        }
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric");
            ddlIsometric.Focus();
        }
        else
        {
            if (WebTools.UserInRole("PIP_DCS_INSERT"))
            {
                AddModalPopupButtonClick("~/Isome/SpoolAdd.aspx?ISO_ID=" + ddlIsometric.SelectedValue, ImageSplButtonAdd.ClientID, 350, 600);

            }
            else
            {
                Master.ShowError("Access Denied!");
            }


        }
    }

    protected void ImageSplButtonDetails_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlSpool.SelectedValue))
        {
            Master.ShowError("Select Isometric and Spool");
            ddlIsometric.Focus();
            ddlSpool.Focus();

        }
        else
        {
            AddModalPopupButtonClick("~/Isome/SpoolDetail.aspx?ISO_ID=" + ddlIsometric.SelectedValue + "&SPL_ID=" + ddlSpool.SelectedValue, ImageSplButtonDetails.ClientID, 550, 600);

        }

    }







    protected void btnSplPDF_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlSpool.SelectedValue))
        {
            Master.ShowError("Select Isometric and Spool to view Spool PDF");
            ddlIsometric.Focus();
            ddlSpool.Focus();

        }
        else
        {
            AddModalPopupButtonClick("~/Isome/ShowPDF_Spool.aspx?SPL_ID=" + ddlSpool.SelectedValue, btnSplPDF.ClientID, 550, 450);

        }
    }

    protected void ImageJntButtonAdd_Click(object sender, ImageClickEventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            ImageJntButtonAdd.Enabled = false;
        }
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric");

        }
        else
        {
            if (WebTools.UserInRole("PIP_WIC_INSERT"))
            {
                AddModalPopupButtonClick("~/Isome/SpoolJointsAdd.aspx?ISO_ID=" + ddlIsometric.SelectedValue, ImageJntButtonAdd.ClientID, 520, 650);


            }
            else
            {
                Master.ShowError("Access Denied!");
            }


        }


    }

    protected void ImageJntButtonDetails_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue))
        {
            Master.ShowError("Select Isometric and  Joint");
            ddlIsometric.Focus();
            ddlJoint.Focus();

        }
        else
        {

            AddModalPopupButtonClick("~/Isome/SpoolJointsDetail.aspx?JOINT_ID=" + ddlJoint.SelectedValue, ImageJntButtonDetails.ClientID, 550, 600);

        }
    }

    public void AddModalPopupButtonClick(string nav_url, string opener_client_Id, int height, int width)
    {
        RadWindowManager windowManager = new RadWindowManager();
        RadWindow newWindow = new RadWindow();
        newWindow.NavigateUrl = nav_url;
        newWindow.Height = Unit.Pixel(height);
        newWindow.Width = Unit.Pixel(width);
        newWindow.ID = opener_client_Id;
        newWindow.VisibleOnPageLoad = true;
        windowManager.Windows.Add(newWindow);
        this.Form.Controls.Add(newWindow);
    }



    protected void ImageSpoolDtNewAdd_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(RadComTransCat.SelectedValue))
        {
            Master.ShowError("Please Select Spool Activity");
            RadComTransCat.Focus();

        }
        else
        {
            switch (RadComTransCat.SelectedValue)
            {
                case "100":
                    if (!WebTools.UserInRole("MM_INSERT"))
                    {
                        Master.ShowMessage("No Access!");
                        return;

                    }
                    else
                    {
                        AddModalPopupButtonClick("~/SpoolFabJobCard/JobCardNew.aspx", ImageSpoolDtNewAdd.ClientID, 500, 600);
                    }

                    break;
                case "101":
                    if (!WebTools.UserInRole("MM_INSERT"))
                    {
                        Master.ShowMessage("No Access!");
                    }
                    else
                    {
                        AddModalPopupButtonClick("~/SpoolMove/SpoolPaintNew.aspx", ImageSpoolDtNewAdd.ClientID, 550, 600);

                    }

                    break;
                case "10":
                case "16":
                case "5":
                case "12":
                    if (!WebTools.UserInRole("MM_INSERT"))
                    {
                        Master.ShowMessage("No Access!");
                    }
                    else
                    {
                        AddModalPopupButtonClick("~/SpoolMove/SpoolTransRegister.aspx?CAT_ID=" + RadComTransCat.SelectedValue, ImageSpoolDtNewAdd.ClientID, 550, 600);
                    }
                    break;

                case "8":
                    AddModalPopupButtonClick("~/SpoolMove/SpoolSRNRegister.aspx?CAT_ID=" + RadComTransCat.SelectedValue, ImageSpoolDtNewAdd.ClientID, 550, 600);
                    break;
                case "14":
                    AddModalPopupButtonClick("~/SpoolMove/SpoolTransferNew.aspx", ImageSpoolDtNewAdd.ClientID, 550, 600);
                    break;
                case "13":
                    AddModalPopupButtonClick("~/SpoolMove/SpoolReceiveNew.aspx", ImageSpoolDtNewAdd.ClientID, 550, 600);
                    break;


            }

        }


    }

    protected void btnBulkImport_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(RadComTransCat.SelectedValue))
        {
            Master.ShowError("Please Select Spool Activity");
            RadComTransCat.Focus();
        }
        else
        {
            switch (RadComTransCat.SelectedValue)
            {
                case "100":

                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=13");

                    break;
                case "101":

                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=21");
                    break;

                case "10":
                case "16":
                case "8":
                case "5":
                case "12":
                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=22");
                    break;

                case "14":
                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=23");
                    break;
                case "13":
                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=24");
                    break;


            }

        }

    }

    protected void btnSpoolDtSave_Click(object sender, EventArgs e)
    {

        string query = "";
        int condition_count = 0;
        try
        {
            if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlSpool.SelectedValue)
              || string.IsNullOrEmpty(RadComTransCat.SelectedValue) || string.IsNullOrEmpty(RadComSpoolReq.SelectedValue))
            {
                Master.ShowError("Select Isometric , Spool & Activity Request");
                ddlIsometric.Focus();
                ddlSpool.Focus();
                RadComTransCat.Focus();
                RadComSpoolReq.Focus();

            }
            else
            {
                switch (RadComTransCat.SelectedValue)
                {
                    case "100":
                        if (!WebTools.UserInRole("SPL_INSERT"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;

                        }
                        query = "INSERT INTO PIP_WORK_ORD_SPOOL (WO_ID, SPL_ID, USER_ID, USER_SOURCE,REMARKS)" +
                                     "VALUES (" + RadComSpoolReq.SelectedValue + "," + ddlSpool.SelectedValue + "," + user_id
                                     + ",'UI','" + txtRemarks.Text + "')";

                        break;
                    case "101":
                        if (!WebTools.UserInRole("SPL_INSERT"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;

                        }
                        query = "INSERT INTO PIP_PAINTING_SPL_DETAIL (SPL_PNT_ID, SPL_ID,REMARKS,FST_COAT_REP, SND_COAT_REP, TRD_COAT_REP, " +
                            "FST_COAT_DT,SND_COAT_DT, TRD_COAT_DT,  EXT_BLST_REP,EXT_BLST_DATE)" +
                                "VALUES (" + RadComSpoolReq.SelectedValue + "," + ddlSpool.SelectedValue + ",'" + txtRemarks.Text + "','"
                                + txt1stPaint.Text + "','" + txt2ndPaint.Text + "','" + txt3rdPaint.Text + "',"
                                + "CASE WHEN '" + String.Format("{0:dd-MMM-yyyy}", date1stPaint.SelectedDate) + "' IS NULL THEN '' ELSE  '"
                                + String.Format("{0:dd-MMM-yyyy}", date1stPaint.SelectedDate) + "' END ,"
                                + "CASE WHEN '" + String.Format("{0:dd-MMM-yyyy}", date2ndPaint.SelectedDate) + "' IS NULL THEN '' ELSE  '"
                                + String.Format("{0:dd-MMM-yyyy}", date2ndPaint.SelectedDate) + "' END ,"
                                + "CASE WHEN '" + String.Format("{0:dd-MMM-yyyy}", date3rdPaint.SelectedDate) + "' IS NULL THEN '' ELSE  '"
                                + String.Format("{0:dd-MMM-yyyy}", date3rdPaint.SelectedDate) + "' END ,'" + txtBlast.Text + "',"
                                + "CASE WHEN '" + String.Format("{0:dd-MMM-yyyy}", dateBlast.SelectedDate) + "' IS NULL THEN '' ELSE  '"
                                + String.Format("{0:dd-MMM-yyyy}", dateBlast.SelectedDate) + "' END )";
                        break;

                    case "10":
                    case "16":
                    case "8":
                    case "5":
                    case "12":
                        if (!WebTools.UserInRole("SPL_INSERT"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;
                        }
                        condition_count = int.Parse(WebTools.CountExpr("SPL_ID", "VIEW_SPOOL_WITH_STATUS", " SPL_ID=" + ddlSpool.SelectedValue + " AND SPOOL != 'EREC' AND HOLD_STATUS = 'N'AND(NDE_BALANCE = 'N' OR SITE_FAB_SPL = 'Y' OR SFR = 'Y' OR NVL(SHOP_ID, 0) = 0)"));
                        if (condition_count > 0)
                        {
                            query = "INSERT INTO PIP_SPOOL_TRANS_DETAIL (TRANS_ID, SPL_ID, CAT_ID,REMARKS)" +
                                  "VALUES (" + RadComSpoolReq.SelectedValue + "," + ddlSpool.SelectedValue + ","
                                  + RadComTransCat.SelectedValue + ",'" + txtRemarks.Text + "')";
                        }
                        else
                        {
                            Master.ShowError("Please check Hold Or NDE Blance Status or other conditions");
                            return;
                        }

                        break;

                    case "14":
                        query = "INSERT INTO PIP_SPL_TRANSFER_DETAIL (TRANS_ID, SPL_ID, REMARKS)" +
                                  "VALUES (" + RadComSpoolReq.SelectedValue + "," + ddlSpool.SelectedValue + ",'" + txtRemarks.Text + "')";
                        break;
                    case "13":
                        if (ddlSubStore.SelectedValue.Length == 0)
                        {
                            Master.ShowError("Select SubStore");
                            return;
                        }
                        else
                        {
                            query = "INSERT INTO PIP_SPL_RECEIVE_DETAIL (RCV_ID, SPL_ID, REMARKS,SUBSTORE_ID)" +
                                                              "VALUES (" + RadComSpoolReq.SelectedValue + "," + ddlSpool.SelectedValue + ",'" + txtRemarks.Text + "'" +
                                                              ",'" + ddlSubStore.SelectedValue + "')";
                        }

                        break;


                }

                WebTools.ExeSql(query);
                Master.ShowSuccess("Spool has been added..");

                UpdateSpoolLabels();

            }
        }
        catch (Exception ex)
        {

            Master.ShowError(ex.ToString());

        }


    }

    protected void RadComTransCat_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComSpoolReq.ClearSelection();
        RadComSpoolReq.Text = string.Empty;
        txtRemarks.Text = null;

        btnSpoolDtUpdate.Visible = false;
        btnSpoolDtDelete.Visible = false;
        DivPaint.Visible = false;
        btnDataImport.Visible = false;
        ddlSubStore.Visible = false;
        switch (RadComTransCat.SelectedValue)
        {


            case "101":
                DivPaint.Visible = true;
                txt1stPaint.Text = null;
                date1stPaint.SelectedDate = null;
                txt2ndPaint.Text = null;
                date2ndPaint.SelectedDate = null;
                txt3rdPaint.Text = null;
                date3rdPaint.SelectedDate = null;
                txtBlast.Text = null;
                dateBlast.SelectedDate = null;

                break;
            case "14":
                btnDataImport.Visible = true;

                break;
            case "13":
                btnDataImport.Visible = true;
                ddlSubStore.Visible = true;

                break;

            default:
                DivPaint.Visible = false;
                btnDataImport.Visible = false;
                ddlSubStore.Visible = false;

                break;

        }



    }

    protected void btnSpoolDtUpdate_Click(object sender, EventArgs e)
    {
        string query = "";
        try
        {
            if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlSpool.SelectedValue)
              || string.IsNullOrEmpty(RadComTransCat.SelectedValue) || string.IsNullOrEmpty(RadComSpoolReq.SelectedValue))
            {
                Master.ShowError("Select Isometric , Spool & Activity Request");
                ddlIsometric.Focus();
                ddlSpool.Focus();
                RadComTransCat.Focus();
                RadComSpoolReq.Focus();
            }
            else
            {
                switch (RadComTransCat.SelectedValue)
                {
                    case "100":
                        if (!WebTools.UserInRole("JOBCARD_DETAIL_EDIT"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;

                        }
                        query = "UPDATE PIP_WORK_ORD_SPOOL SET REMARKS='" + txtRemarks.Text + "' WHERE WO_ID=" + RadComSpoolReq.SelectedValue + " AND SPL_ID=" + ddlSpool.SelectedValue;

                        break;
                    case "101":
                        if (!WebTools.UserInRole("SPOOL_PAINT_DETAIL_EDIT"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;

                        }
                        query = "UPDATE PIP_PAINTING_SPL_DETAIL SET  FST_COAT_REP='" + txt1stPaint.Text + "', SND_COAT_REP='" + txt2ndPaint.Text
                            + "', TRD_COAT_REP='" + txt3rdPaint.Text + "', FST_COAT_DT='" + date1stPaint.SelectedDate.Value.ToString("dd-MMM-yyyy") + "'" +
                            ", SND_COAT_DT='" + date2ndPaint.SelectedDate.Value.ToString("dd-MMM-yyyy") + "', TRD_COAT_DT='" + date3rdPaint.SelectedDate.Value.ToString("dd-MMM-yyyy")
                            + "',  EXT_BLST_REP ='" + txtBlast.Text + "'" + ",EXT_BLST_DATE='" + dateBlast.SelectedDate.Value.ToString("dd-MMM-yyyy")
                            + "',REMARKS = '" + txtRemarks.Text + "' WHERE SPL_PNT_ID=" + RadComSpoolReq.SelectedValue + " AND SPL_ID=" + ddlSpool.SelectedValue;
                        break;

                    case "10":
                    case "16":
                    case "8":
                    case "5":
                    case "12":
                        if (!WebTools.UserInRole("SPOOL_TRANS_DETAIL_EDIT"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;
                        }
                        query = "UPDATE PIP_SPOOL_TRANS_DETAIL SET REMARKS = '" + txtRemarks.Text + "' WHERE TRANS_ID = " + RadComSpoolReq.SelectedValue + " AND SPL_ID = " + ddlSpool.SelectedValue;
                        break;
                    case "14":
                        query = "UPDATE PIP_SPL_TRANSFER_DETAIL SET REMARKS = '" + txtRemarks.Text + "' WHERE TRANS_ID = " + RadComSpoolReq.SelectedValue + " AND SPL_ID = " + ddlSpool.SelectedValue;
                        break;
                    case "13":


                        query = "UPDATE PIP_SPL_RECEIVE_DETAIL SET REMARKS = '" + txtRemarks.Text + "' WHERE RCV_ID = " + RadComSpoolReq.SelectedValue + " AND SPL_ID = " + ddlSpool.SelectedValue;


                        break;

                }

                WebTools.ExeSql(query);
                Master.ShowSuccess("Updated.");
                UpdateSpoolLabels();
            }
        }
        catch (Exception ex)
        {

            Master.ShowError(ex.ToString());

        }
    }
    protected void btnSpoolDtDelete_Click(object sender, EventArgs e)
    {
        string query = "";
        try
        {
            if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlSpool.SelectedValue)
              || string.IsNullOrEmpty(RadComTransCat.SelectedValue) || string.IsNullOrEmpty(RadComSpoolReq.SelectedValue))
            {
                Master.ShowError("Select Isometric , Spool & Activity Request");
                ddlIsometric.Focus();
                ddlSpool.Focus();
                RadComTransCat.Focus();
                RadComSpoolReq.Focus();
            }
            else
            {
                switch (RadComTransCat.SelectedValue)
                {
                    case "100":
                        if (!WebTools.UserInRole("JOBCARD_DETAIL_DELETE"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;

                        }
                        query = "DELETE FROM PIP_WORK_ORD_SPOOL  WHERE WO_ID=" + RadComSpoolReq.SelectedValue + " AND SPL_ID=" + ddlSpool.SelectedValue;

                        break;
                    case "101":
                        if (!WebTools.UserInRole("SPOOL_PAINT_DETAIL_DELETE"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;

                        }
                        query = "DELETE FROM PIP_PAINTING_SPL_DETAIL WHERE SPL_PNT_ID=" + RadComSpoolReq.SelectedValue + " AND SPL_ID=" + ddlSpool.SelectedValue;
                        break;

                    case "10":
                    case "16":
                    case "8":
                    case "5":
                    case "12":
                        if (!WebTools.UserInRole("SPOOL_TRANS_DETAIL_DELETE"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;
                        }
                        query = "DELETE FROM  PIP_SPOOL_TRANS_DETAIL  WHERE TRANS_ID = " + RadComSpoolReq.SelectedValue + " AND SPL_ID = " + ddlSpool.SelectedValue;
                        break;
                    case "14":
                        if (!WebTools.UserInRole("SPOOL_TRANS_DETAIL_DELETE"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;
                        }
                        query = "DELETE FROM  PIP_SPL_TRANSFER_DETAIL  WHERE TRANS_ID = " + RadComSpoolReq.SelectedValue + " AND SPL_ID = " + ddlSpool.SelectedValue;
                        break;
                    case "13":
                        if (!WebTools.UserInRole("SPOOL_TRANS_DETAIL_DELETE"))
                        {
                            Master.ShowWarn("Access Denied!");
                            return;
                        }

                        query = "DELETE FROM PIP_SPL_RECEIVE_DETAIL  WHERE RCV_ID = " + RadComSpoolReq.SelectedValue + " AND SPL_ID = " + ddlSpool.SelectedValue;


                        break;

                }

                WebTools.ExeSql(query);
                Master.ShowSuccess("Deleted..");
                UpdateSpoolLabels();
            }
        }
        catch (Exception ex)
        {

            Master.ShowError(ex.ToString());

        }
    }
    protected void RadComSpoolReq_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        int data_id = 0;


        switch (RadComTransCat.SelectedValue)
        {
            case "100":
                data_id = int.Parse(WebTools.CountExpr("SPL_ID", "PIP_WORK_ORD_SPOOL", " WO_ID='" + RadComSpoolReq.SelectedValue + "' AND SPL_ID='"
                    + ddlSpool.SelectedValue + "'"));

                break;
            case "101":
                txt1stPaint.Text = null;
                date1stPaint.SelectedDate = null;
                txt2ndPaint.Text = null;
                date2ndPaint.SelectedDate = null;
                txt3rdPaint.Text = null;
                date3rdPaint.SelectedDate = null;
                txtBlast.Text = null;
                dateBlast.SelectedDate = null;
                txtRemarks.Text = null;
                OracleConnection Paint_conn = WebTools.GetIpmsConnection();
                if (Paint_conn.State != ConnectionState.Open)
                {
                    Paint_conn.Open();
                }

                OracleDataReader myReader = null;
                OracleCommand myCommand = new OracleCommand
                    ("SELECT * from PIP_PAINTING_SPL_DETAIL WHERE SPL_PNT_ID='" + RadComSpoolReq.SelectedValue + "' AND SPL_ID='"
                  + ddlSpool.SelectedValue + "'", Paint_conn);
                myReader = myCommand.ExecuteReader();
                while (myReader.Read())
                {
                    txt1stPaint.Text = myReader["FST_COAT_REP"].ToString();
                    date1stPaint.SelectedDate = String.IsNullOrEmpty(myReader["FST_COAT_DT"].ToString()) ? (DateTime?)null : DateTime.Parse(myReader["FST_COAT_DT"].ToString());
                    txt2ndPaint.Text = myReader["SND_COAT_REP"].ToString();
                    date2ndPaint.SelectedDate = String.IsNullOrEmpty(myReader["SND_COAT_DT"].ToString()) ? (DateTime?)null : DateTime.Parse(myReader["SND_COAT_DT"].ToString());
                    txt3rdPaint.Text = myReader["TRD_COAT_REP"].ToString();
                    date3rdPaint.SelectedDate = String.IsNullOrEmpty(myReader["TRD_COAT_DT"].ToString()) ? (DateTime?)null : DateTime.Parse(myReader["TRD_COAT_DT"].ToString());
                    txtBlast.Text = myReader["EXT_BLST_REP"].ToString();
                    dateBlast.SelectedDate = String.IsNullOrEmpty(myReader["EXT_BLST_DATE"].ToString()) ? (DateTime?)null : DateTime.Parse(myReader["EXT_BLST_DATE"].ToString());
                    txtRemarks.Text = myReader["REMARKS"].ToString();

                }
                Paint_conn.Close();
                data_id = int.Parse(WebTools.CountExpr("SPL_ID", "PIP_PAINTING_SPL_DETAIL", " SPL_PNT_ID='" + RadComSpoolReq.SelectedValue + "' AND SPL_ID='"
                  + ddlSpool.SelectedValue + "'"));


                break;

            case "10":
            case "16":
            case "8":
            case "5":
            case "12":

                data_id = int.Parse(WebTools.CountExpr("SPL_ID", "PIP_SPOOL_TRANS_DETAIL", " TRANS_ID='" + RadComSpoolReq.SelectedValue + "' AND SPL_ID='"
                  + ddlSpool.SelectedValue + "'"));



                break;

            case "14":
                data_id = int.Parse(WebTools.CountExpr("SPL_ID", "PIP_SPL_TRANSFER_DETAIL", " TRANS_ID='" + RadComSpoolReq.SelectedValue + "' AND SPL_ID='"
                 + ddlSpool.SelectedValue + "'"));

                break;
            case "13":

                data_id = int.Parse(WebTools.CountExpr("SPL_ID", "PIP_SPL_RECEIVE_DETAIL", " RCV_ID='" + RadComSpoolReq.SelectedValue + "' AND SPL_ID='"
               + ddlSpool.SelectedValue + "'"));


                break;

        }

        if (data_id > 0)
        {
            btnSpoolDtSave.Visible = false;
            btnSpoolDtUpdate.Visible = true;
            btnSpoolDtDelete.Visible = true;
            if (btnSpoolDtUpdate.Visible && RadComTransCat.SelectedValue == "13")
            {
                ddlSubStore.Visible = false;
            }

        }
        else
        {
            btnSpoolDtSave.Visible = true;
            btnSpoolDtUpdate.Visible = false;
            if (!btnSpoolDtUpdate.Visible && RadComTransCat.SelectedValue == "13")
            {
                ddlSubStore.Visible = true;
            }




        }

    }

    protected void ddlSpool_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComSpoolReq.ClearSelection();
        RadComSpoolReq.Text = string.Empty;
        RadComTransCat.ClearSelection();
        RadComTransCat.Text = string.Empty;
        ddlJoint.ClearSelection();
        ddlJoint.Text = string.Empty;
        ddlBom.ClearSelection();
        ddlBom.Text = string.Empty;

        DivPaint.Visible = false;
        ddlSubStore.Visible = false;
        btnDataImport.Visible = false;

        UpdateSpoolLabels();
    }

    protected void ddlIsometric_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddlSpool.ClearSelection();
        ddlSpool.Text = string.Empty;
        ddlJoint.ClearSelection();
        ddlJoint.Text = string.Empty;
        ddlBom.ClearSelection();
        ddlBom.Text = string.Empty;


    }

    protected void btnDataImport_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(RadComSpoolReq.SelectedValue))
        {
            Master.ShowError("Please Select Request");

            RadComSpoolReq.Focus();
        }
        else
        {
            switch (RadComTransCat.SelectedValue)
            {
                case "14":
                    AddModalPopupButtonClick("~/SpoolMove/SpoolTransferDetailAdd.aspx?TRANS_ID=" + RadComSpoolReq.SelectedValue, btnDataImport.ClientID, 550, 600);
                    break;
                case "13":
                    AddModalPopupButtonClick("~/SpoolMove/SpoolReceiveImport.aspx?id=" + Request.QueryString["id"], btnDataImport.ClientID, 500, 1000);
                    break;
            }
        }
    }

    protected void RadComJointActivity_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        ddlSubcon.Visible = true;
        jointDetailsView.Visible = true;
        NdeDetailsView.Visible = false;
        switch (RadComJointActivity.SelectedValue)
        {
            case "1":
                Fitup_Entry.Visible = true;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = false;
                Nde_hide.Visible = false;
                JointBulkImport.Visible = true;

                ddlFitupInspCode.Items.Clear();
                ddlFitupInspCode.Items.Insert(0, new DropDownListItem("Fitup Inspector", "Fitup Inspector"));
                ddlFitupInspCode.DataBind();

                break;
            case "2":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = true;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = false;
                Nde_hide.Visible = false;
                JointBulkImport.Visible = true;

                rcbWeldInsp.Items.Clear();
                rcbWeldInsp.Items.Insert(0, new RadComboBoxItem("Weld Inspector", "Weld Inspector"));
                rcbWeldInsp.DataBind();
                break;

            case "3":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = true;
                Bonding.Visible = false;
                Nde_hide.Visible = false;
                JointBulkImport.Visible = false;

                break;
            case "4":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = true;
                Nde_hide.Visible = false;
                JointBulkImport.Visible = false;

                break;
            case "5":
                Fitup_Entry.Visible = false;
                Weld_Entry.Visible = false;
                GRE_LAMINATION.Visible = false;
                Bonding.Visible = false;
                Nde_hide.Visible = true;
                JointBulkImport.Visible = true;

                ddlSubcon.Visible = false;
                jointDetailsView.Visible = false;
                NdeDetailsView.Visible = true;

                break;


        }


    }

    protected void FitupSave_Click(object sender, EventArgs e)
    {
        string joint = ddlJoint.SelectedValue.ToString();
        string fitup_date = WebTools.GetExpr("FITUP_DATE", "PIP_SPOOL_JOINTS", "JOINT_ID=" + ddlJoint.SelectedValue.ToString());
        string fitup_rep_no = WebTools.GetExpr("FITUP_REP_NO", "PIP_SPOOL_JOINTS", "JOINT_ID=" + ddlJoint.SelectedValue.ToString());
        if (joint == string.Empty || joint == "-1" || joint == "")
        {
            Master.ShowError("Select Joint");
            ddlJoint.Focus();

            return;
        }
        if (fitup_date.Length > 0 || fitup_rep_no.Length > 0)
        {
            Master.ShowError("Fitup Done for this joint");
            return;
        }
        string bom1 = WebTools.GetExpr("ITEM_1", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + ddlJoint.SelectedValue.ToString());
        string bom2 = WebTools.GetExpr("ITEM_2", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + ddlJoint.SelectedValue.ToString());
        if (bom1 == "" || bom2 == "")
        {
            return;
        }
        string mat_id1 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom1);
        string mat_id2 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + bom2);
        string item_id1 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id1);
        string item_id2 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + mat_id2);

        if (item_id1 == "" || item_id2 == "")
        {
            Master.ShowError("Update Item name for BOM");
            return;
        }

        string item_group1 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id1);
        string item_group2 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID=" + item_id2);
        string hn1 = "";
        string hn2 = "";
        if (item_group1 == "SUPPORT")
        {
            hn1 = txtSuppHeatNo1.Text;
            if (hn1 == "")
            {
                Master.ShowError("Selected Valid Heat No1");
                return;
            }
        }
        else
        {
            if (rcbHeatNo1.SelectedIndex < 0)
            {
                Master.ShowError("Selected Valid Heat No1");
                return;
            }
            hn1 = rcbHeatNo1.SelectedValue.ToString();
        }

        if (item_group2 == "SUPPORT")
        {
            hn2 = txtSuppHeatNo2.Text;
            if (hn2 == "")
            {
                Master.ShowError("Selected Valid Heat No2");
                return;
            }
        }
        else
        {
            if (rcbHeatNo2.SelectedIndex < 0 && rcbHeatNo2.SelectedValue.ToString() == string.Empty)
            {
                Master.ShowError("Selected Valid Heat No2");
                return;
            }
            hn2 = rcbHeatNo2.SelectedValue.ToString();
        }

        DateTime Date3 = System.DateTime.Now;
        string fitup_entry_date = Date3.ToString("dd-MMM-yyyy");

        PIP_SPOOL_JOINTSTableAdapter joint_fitup = new PIP_SPOOL_JOINTSTableAdapter();
        joint_fitup.UpdateJointFitup(txtFitupRep.Text, DateTime.Parse(txtFitupDate.SelectedDate.ToString()), ddlFitupInspCode.SelectedValue.ToString(), hn1, hn2, DateTime.Parse(fitup_entry_date), txtFitupForeman.Text, int.Parse(ddlJoint.SelectedValue));

        string sql_heat_no = "UPDATE PIP_BOM SET HEAT_NO = '" + hn1 + "' WHERE BOM_ID = " + bom1 + " and HEAT_NO IS NULL";
        WebTools.ExeSql(sql_heat_no);
        sql_heat_no = "UPDATE PIP_BOM SET HEAT_NO = '" + hn2 + "' WHERE BOM_ID = " + bom2 + " AND HEAT_NO IS NULL";
        WebTools.ExeSql(sql_heat_no);

        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
          "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
           "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
           " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
           "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, ddlJoint.SelectedValue.ToString());
        jointDetailsView.DataBind();
        rcbHeatNo1.Text = "";
        rcbHeatNo2.Text = "";
        Master.ShowSuccess("Fitup Details Updated Successfully");

    }

    protected void WeldSave_Click(object sender, EventArgs e)
    {
        string sql, wps_no;
        string welder = string.Empty;
        wps_no = string.Empty;
        // string joint_id = ddlJointNo.SelectedValue.ToString();
        string joint_id = ddlJoint.SelectedValue.ToString();
        DateTime DATE = (DateTime)txtWeldDate.SelectedDate;
        string date_ = DATE.ToString("dd-MMM-yyyy");
        DateTime DATE2 = (DateTime)txtInspDate.SelectedDate;
        string insp_date = DATE2.ToString("dd-MMM-yyyy");
        DateTime Date3 = System.DateTime.Now;
        string weld_entry_date = Date3.ToString("dd-MMM-yyyy");
        string rep_no = "'" + txtWeldRepNo.Text + "'";
        string insp = "'" + rcbWeldInsp.Text + "'";

        DateTime fitup_date;
        string joint = ddlJoint.SelectedValue.ToString();
        string weld_date = WebTools.GetExpr("WELD_DATE", "PIP_SPOOL_JOINTS", "JOINT_ID=" + ddlJoint.SelectedValue.ToString());
        string weld_rep_no = WebTools.GetExpr("WELD_REP_NO", "PIP_SPOOL_JOINTS", "JOINT_ID=" + ddlJoint.SelectedValue.ToString());
        if (joint == string.Empty || joint == "-1" || joint == "")
        {
            Master.ShowError("Select Joint");
            ddlJoint.Focus();
            return;
        }

        if (weld_date.Length > 0 || weld_rep_no.Length > 0)
        {
            Master.ShowError("Weld Done for this joint");
            return;
        }
        try
        {
            fitup_date = DateTime.Parse(WebTools.GetExpr("FITUP_DATE", "PIP_SPOOL_JOINTS", "JOINT_ID=" + ddlJoint.SelectedValue.ToString()));
            if (DateTime.Parse(txtWeldDate.SelectedDate.ToString()) < (DateTime)(fitup_date))
            {
                Master.ShowError("Weld Date cannot be before fitup date!");
                return;
            }
        }
        catch (Exception ex)
        {
            Master.ShowError("Weld date is less than fitup date !" + ex.Message);
            return;
        }

        if (DATE > DateTime.Parse(System.DateTime.Now.ToString()))
        {
            Master.ShowError("Weld Date cannot be updated greater than Today Date");
            return;
        }

        //swn check
        string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + ddlJoint.SelectedValue);
        int swn_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_SWN_SPOOL WHERE SPL_ID=" + spl_id));
        int rel_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_REL_REQ_SPL WHERE SPL_ID=" + spl_id));

        if (swn_cnt > rel_cnt)
        {
            Master.ShowError("Spool Under SWN!");

            return;
        }

        if (weldersListBox.Items.Count <= 0)
        {
            Master.ShowError("Select Welder");
            return;
        }
        if (ddlWeldWps.SelectedIndex < 0)
        {
            Master.ShowError("Select WPS No");
            return;
        }
        //   string wps_entry = WebTools.GetExpr("DAILY_WLD_WPS", "PROJECT_INFORMATION"," WHERE PROJECT_ID=" + Session["PROJECT_ID"].ToString());

        wps_no = ddlWeldWps.SelectedItem.Text.ToString();


        //  sql = "UPDATE PIP_SPOOL_JOINTS SET  WELD_DATE = '" + date_ + "'" + ",WELD_MACHINE = '" + txtWeldMachine.Text + "', SHIFT_TIME = '" + ddlSiftTime.SelectedValue + "', WELD_REP_NO=" + rep_no + ",WELD_INSP=" + insp + ",WELD_INSP_DATE='" + insp_date + "'" + ",WELD_ENTRY_DATE='" + weld_entry_date + "'";
        sql = "UPDATE PIP_SPOOL_JOINTS SET  WELD_DATE = '" + date_ + "'" + ",WELD_INSP_RESULT='" + txtInspResult.Text + "',WELD_MACHINE = null, SHIFT_TIME = 'null', WELD_REP_NO=" + rep_no + ",WELD_INSP=" + insp + ",WELD_INSP_DATE='" + insp_date + "'" + ",WELD_ENTRY_DATE='" + weld_entry_date + "'" + ",WELD_FOREMAN='" + txtWeldForeman.Text + "'";
        if (wps_no != "") sql += ",WPS_NO='" + wps_no + "'";
        // if (txtConsumable.Text != "") sql += ",CNS_BATCH='" + txtConsumable.Text + "'";
        sql += " WHERE JOINT_ID=" + joint_id;

        WebTools.ExeSql(sql);


        //Add Welders
        if (weldersListBox.Items.Count > 0)
        {
            for (int i = 0; i < weldersListBox.Items.Count; i++)
            {
                welder = weldersListBox.Items[i].Value.ToString();
                string welder_exist = WebTools.GetExpr("WELDER_ID", "PIP_SPOOL_WELDING", " WHERE JOINT_ID=" + joint_id + " AND WELDER_ID=" + welder.Substring(0, welder.IndexOf("-")) + " AND PASS_ID=" + welder.Substring(welder.IndexOf("-") + 1));
                if (welder_exist == "")
                    WebTools.ExeSql("INSERT INTO PIP_SPOOL_WELDING(JOINT_ID, WELDER_ID, PASS_ID) VALUES(" + joint_id + "," +
                        welder.Substring(0, welder.IndexOf("-")) + "," + welder.Substring(welder.IndexOf("-") + 1) + ")");

            }
            string root_hot = WebTools.GetExpr("ROOT_HOT", "VIEW_JNT_WELDER_UPDATE", " WHERE JOINT_ID=" + joint_id);
            string fill_cap = WebTools.GetExpr("FILL_CAP", "VIEW_JNT_WELDER_UPDATE", " WHERE JOINT_ID=" + joint_id); ;

            string weld_jnt_sql = "UPDATE PIP_SPOOL_JOINTS SET ROOT_HOT_WELDER='" + root_hot + "',FILL_CAP_WELDER='" + fill_cap + "' where joint_id=" + joint_id;
            WebTools.ExeSql(weld_jnt_sql);
        }

        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
     "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
      "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
      " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
      "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";

        Master.ShowMessage("Joint welding updated successfully");
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, ddlJoint.SelectedValue.ToString());

        jointDetailsView.DataBind();
        ddlWeldWps.ClearSelection();
        ddlWeldWps.Items.Clear();
        ddlWelder.ClearSelection();
        // ddlWeldWps.DataBind();


    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlWelder.SelectedValue.ToString() == "-1")
            {
                Master.ShowWarn("Select the weld!");
                ddlWelder.Focus();
                return;
            }
            if (ddlWelderPass.SelectedValue.ToString() == "-1")
            {
                Master.ShowWarn("Select the welder category!");
                return;
            }
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + ddlWelderPass.SelectedItem.Text,
                ddlWelder.SelectedItem.Value.ToString() + "-" + ddlWelderPass.SelectedValue.ToString()));
        }

        catch (Exception ex)
        {
            Master.ShowError("Select a welder !");
            return;
        }
    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        try
        {
            if (weldersListBox.SelectedIndex == -1)
            {
                Master.ShowError("Select the weld!");
                weldersListBox.Focus();
                return;
            }
            weldersListBox.Items.Remove(weldersListBox.Items[weldersListBox.SelectedIndex]);
        }

        catch (Exception ex)
        {
            Master.ShowError("Select a row from the box !");
            return;
        }
    }

    protected void btnRemoveAll_Click(object sender, EventArgs e)
    {
        weldersListBox.Items.Clear();
    }
    protected void btnAddWelderAll_Click(object sender, EventArgs e)
    {
        try
        {
            //weldersListBox.Items.Clear();
            if (ddlWelder.SelectedValue.ToString() == "-1")
            {
                Master.ShowError("Select a welder !");
                ddlWelder.Focus();
                return;
            }

            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "ROOT PASS", ddlWelder.SelectedItem.Value.ToString() + "-" + "1")
                );
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "HOT PASS", ddlWelder.SelectedItem.Value.ToString() + "-" + "2")
                );
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "FILL", ddlWelder.SelectedItem.Value.ToString() + "-" + "3")
                );
            weldersListBox.Items.Add(new
                Telerik.Web.UI.RadListBoxItem(ddlWelder.SelectedItem.Text + "/" + "CAP", ddlWelder.SelectedItem.Value.ToString() + "-" + "4")
                );
        }
        catch (Exception ex)
        {
            Master.ShowError("Select a welder !");
            return;
        }
    }
    protected void btnLamination_Click(object sender, EventArgs e)
    {
        string joint = ddlJoint.SelectedValue.ToString();
        if (joint == string.Empty || joint == "-1" || joint == "")
        {
            Master.ShowError("Select Joint");
            ddlJoint.Focus();
            return;
        }

        PIP_SPOOL_JOINTSTableAdapter joint_lam = new PIP_SPOOL_JOINTSTableAdapter();
        joint_lam.UpdateLaminate(txtLamRep.Text, DateTime.Parse(txtLamDate.SelectedDate.ToString()), txtLamHeatNo1.Text, txtLamHeatNo2.Text, txtLamTHK.Text, int.Parse(ddlJoint.SelectedValue));


        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
         "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
          "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
          " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
          "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, ddlJoint.SelectedValue.ToString());
        jointDetailsView.DataBind();
        rcbHeatNo1.Text = "";
        rcbHeatNo2.Text = "";
        Master.ShowSuccess("Lamination Details Updated Successfully");
    }
    protected void btnBonding_Click(object sender, EventArgs e)
    {
        string joint = ddlJoint.SelectedValue.ToString();
        if (joint == string.Empty || joint == "-1" || joint == "")
        {
            Master.ShowError("Select Joint");
            ddlJoint.Focus();
            return;
        }

        PIP_SPOOL_JOINTSTableAdapter joint_Bonding = new PIP_SPOOL_JOINTSTableAdapter();
        joint_Bonding.UpdateBonding(txtBondingRep.Text, DateTime.Parse(txtBondingDate.SelectedDate.ToString()), txtBondingName.Text, DateTime.Parse(txtCuringDate.SelectedDate.ToString()), int.Parse(ddlJoint.SelectedValue));


        string sql_1 = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK," +
          "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER," +
           "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, COMMODITY1, COMMODITY2,TW_FLG, SPL_SWN_DT, SPL_REL_DT, LINE_CLASS, MAT_TYPE ," +
           " SPL_REL_DT, SPL_SWN_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME,FITUP_FOREMAN,WELD_FOREMAN " +
           "FROM  VIEW_TOTAL_JOINTS  WHERE (JOINT_ID = :JOINT_ID)";
        jointDetailsDataSource1.SelectCommand = sql_1;
        jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, ddlJoint.SelectedValue.ToString());
        jointDetailsView.DataBind();
        rcbHeatNo1.Text = "";
        rcbHeatNo2.Text = "";
        Master.ShowSuccess("Bonding Details Updated Successfully");

    }


    protected void ddlJoint_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {

        string joint = ddlJoint.SelectedValue.ToString();

        if (joint != string.Empty && joint != "-1" && joint != "")
        {
            string weld_wps = WebTools.GetExpr("WPS_NO", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
            rcbHeatNo1.Enabled = true;
            rcbHeatNo2.Enabled = true;
            rcbHeatNo1.Items.Clear();
            rcbHeatNo2.Items.Clear();
            rcbHeatNo1.DataBind();
            rcbHeatNo2.DataBind();
            rcbHeatNo1.Text = "";
            rcbHeatNo2.Text = "";
            ddlWeldWps.ClearSelection();
            ddlWeldWps.Text = string.Empty;
            ddlWelder.ClearSelection();
            ddlWelder.Text = string.Empty;

            //IsoIdField.Value = WebTools.GetExpr("ISO_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + ddlJointNo.SelectedValue.ToString());
            string bom1 = WebTools.GetExpr("ITEM_1", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
            string bom2 = WebTools.GetExpr("ITEM_2", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);

            if (string.IsNullOrEmpty(bom1) || string.IsNullOrEmpty(bom2))
            {
                Master.ShowError("Set Items are not defined for this Joint, Update in Joints page.!");
                return;
            }
            string spl_id = WebTools.GetExpr("SPL_ID", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
            int swn_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_SWN_SPOOL WHERE SPL_ID=" + spl_id));
            int rel_cnt = int.Parse(WebTools.ExeSql("SELECT COUNT(*) FROM PIP_REL_REQ_SPL WHERE SPL_ID=" + spl_id));

            if (swn_cnt > rel_cnt)
            {
                Master.ShowError("Spool Under SWN!");

                return;
            }
            string jnt_type = WebTools.GetExpr("JOINT_TYPE", "PIP_SPOOL_JOINTS", "  WHERE JOINT_ID=" + joint);

            string mat_id1 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID='" + bom1 + "'");
            string mat_id2 = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID='" + bom2 + "'");
            rcbHeatNo1.DataBind();
            rcbHeatNo2.DataBind();
            string item_id1 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID='" + mat_id1 + "'");
            string item_id2 = WebTools.GetExpr("ITEM_ID", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID='" + mat_id2 + "'");

            string item_group1 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID='" + item_id1 + "'");
            string item_group2 = WebTools.GetExpr("SG_GROUP", "AMOGH.PIP_MAT_ITEM", " WHERE ITEM_ID='" + item_id2 + "'");
            string heat_no1 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", " WHERE BOM_ID='" + bom1 + "'");

            if (item_group1 == "SUPPORT")
            {
                txtSuppHeatNo1.Visible = true;
                rcbHeatNo1.Visible = false;
                if (heat_no1 != string.Empty)
                {
                    txtSuppHeatNo1.Text = heat_no1;
                    //txtSuppHeatNo2.Enabled = false;
                }
            }
            else
            {
                if (heat_no1 != "")
                {
                    string hn1 = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_HN", " WHERE MAT_ID ='" + mat_id1 + "'");
                    if (hn1 == string.Empty)
                    {
                        rcbHeatNo1.Items.Insert(0, new RadComboBoxItem(heat_no1, heat_no1));
                        rcbHeatNo1.SelectedIndex = 0;
                        //rcbHeatNo1.Enabled = false;

                    }
                    else
                    {

                        rcbHeatNo1.SelectedValue = heat_no1;
                        rcbHeatNo1.SelectedIndex = 0;
                        //rcbHeatNo1.Enabled = false;
                    }
                }
                txtSuppHeatNo1.Visible = false;
                rcbHeatNo1.Visible = true;
            }
            string heat_no2 = WebTools.GetExpr("HEAT_NO", "PIP_BOM", " WHERE BOM_ID='" + bom2 + "'");
            if (item_group2 == "SUPPORT")
            {
                txtSuppHeatNo2.Visible = true;
                rcbHeatNo2.Visible = false;
                if (heat_no2 != string.Empty)
                {
                    txtSuppHeatNo2.Text = heat_no2;
                    //txtSuppHeatNo2.Enabled = false;
                }
            }
            else
            {
                if (heat_no2 != "")
                {

                    string hn2 = WebTools.GetExpr("HEAT_NO", "VIEW_MRIR_HN", " WHERE MAT_ID ='" + mat_id2 + "'");
                    if (hn2 == string.Empty)
                    {
                        rcbHeatNo2.Items.Insert(0, new RadComboBoxItem(heat_no2, heat_no2));
                        rcbHeatNo2.SelectedIndex = 0;
                        //rcbHeatNo2.Enabled = false;

                    }
                    else
                    {
                        rcbHeatNo2.SelectedValue = heat_no2;
                        rcbHeatNo2.SelectedIndex = 0;
                        //rcbHeatNo2.Enabled = false;
                    }
                }
                txtSuppHeatNo2.Visible = false;
                rcbHeatNo2.Visible = true;
            }

            string joint_size = WebTools.GetExpr("JOINT_SIZE_DEC", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);
            string joint_thk = WebTools.GetExpr("JOINT_THK", "PIP_SPOOL_JOINTS", " WHERE JOINT_ID=" + joint);

            txtJoint_size.Text = joint_size;
            txtJoint_thk.Text = joint_thk;


            string sql = "SELECT JOINT_ID, ISO_TITLE1, ISO_REV, JC_REV, SHEET, SPOOL, WO_NAME, JOINT_NO, JOINT_TYPE, JOINT_SIZE, SCHEDULE, JOINT_THK, " +
                   "HEAT_NO1, HEAT_NO2, FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, ROOT_HOT_WELDER,FILL_CAP_WELDER,FITUP_INSP,WELD_INSP, CRW_CODE, TRACER, " +
                    "DIS_FLG, WPS_NO, CAT_NAME, JNT_REV_CODE AS REV_CODE, mat_code1 AS COMMODITY1, mat_code2 AS COMMODITY2,TW_FLG,  mat_class AS LINE_CLASS, MAT_TYPE,SPL_SWN_DT,SPL_REL_DT,LAMINAT_REP_NO,LAMINAT_DATE,LAMINAT_THK,BONDING_REP_NO,BONDING_DATE,BONDER_NAME " +
                    " FROM  view_adapter_joints WHERE(JOINT_ID = :JOINT_ID)";
            jointDetailsDataSource1.SelectCommand = sql;
            jointDetailsDataSource1.SelectParameters.Add("JOINT_ID", TypeCode.Empty, ddlJoint.SelectedValue.ToString());
            jointDetailsView.DataBind();

        }
        else
        {
            Master.ShowMessage("Please Select Joint");
            ddlJoint.Focus();
        }


    }

    protected void JointBulkImport_Click(object sender, EventArgs e)
    {

        if (string.IsNullOrEmpty(RadComJointActivity.SelectedValue))
        {
            Master.ShowError("Please Select Joint Activity");
            RadComJointActivity.Focus();
        }
        else
        {
            switch (RadComJointActivity.SelectedValue)
            {
                case "1":

                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=17");

                    break;
                case "2":

                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=16");
                    break;
                case "5":

                    Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=18");
                    break;

            }


        }
    }

    protected void ImageBomButtonAdd_Click(object sender, ImageClickEventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            ImageJntButtonAdd.Enabled = false;
        }
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric");
            ddlIsometric.Focus();

        }
        else
        {
            if (WebTools.UserInRole("MM_INSERT"))
            {
                AddModalPopupButtonClick("~/Isome/SpoolBOM_Add.aspx?ISO_ID=" + ddlIsometric.SelectedValue, ImageBomButtonAdd.ClientID, 450, 600);

            }
            else
            {
                Master.ShowError("Access Denied!");
            }


        }

    }

    protected void ImageBomButtonDetails_Click(object sender, ImageClickEventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlBom.SelectedValue))
        {
            Master.ShowError("Select Isometric and  Bom");
            ddlIsometric.Focus();
            ddlBom.Focus();

        }
        else
        {

            AddModalPopupButtonClick("~/Isome/SpoolBOM_Detail.aspx?ISO_ID=" + ddlIsometric.SelectedValue + "&BOM_ID=" + ddlBom.SelectedValue, ImageBomButtonDetails.ClientID, 550, 600);

        }
    }

    protected void btnItemCode_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlBom.SelectedValue))
        {
            Master.ShowError("Select Isometric and  Bom");
            ddlIsometric.Focus();
            ddlBom.Focus();

            return;
        }
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowMessage("Access denied!");
            return;
        }
        if (ItemCodeUpdate.Visible == false)
        {
            ItemCodeUpdate.Visible = true;
            string MAT_ID = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + ddlBom.SelectedValue);
            txtItemCode.Text = WebTools.GetExpr("MAT_CODE1", "AMOGH.PIP_MAT_STOCK", " WHERE MAT_ID=" + MAT_ID);
        }
        else
        {
            ItemCodeUpdate.Visible = false;
        }
    }

    protected void btnSaveItemCode_Click(object sender, EventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            Master.ShowError("Access Denied. Spool locked in Testpack.");
            return;
        }

        decimal mat_id = db_lookup.MAT_ID(txtItemCode.Text, decimal.Parse(Session["PROJECT_ID"].ToString()));
        if (mat_id == -1)
        {
            Master.ShowWarn("There are two materials with the same code! try to use the unique one.");
            return;
        }
        else if (mat_id == 0)
        {
            Master.ShowWarn("Material Code not found!");
            return;
        }
        try
        {
            WebTools.ExeSql("UPDATE PIP_BOM SET MAT_ID=" + mat_id.ToString() + " WHERE BOM_ID=" + ddlBom.SelectedValue);
            Master.ShowMessage("Item Code Saved!");
            ItemCodeUpdate.Visible = false;
        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }

    protected void btnMove_Click(object sender, EventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");
        if (tpk_lock == "Y")
        {
            Master.ShowError("Access Denied. Spool locked in Testpack.");
            return;
        }
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlBom.SelectedValue))
        {
            Master.ShowError("Select Isometric and  Bom");
            ddlIsometric.Focus();
            ddlBom.Focus();
            return;
        }

        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            Master.ShowMessage("Access denied!");
            return;
        }


        if (!cboBomMove.Visible)
        {
            cboBomMove.Visible = true;
            btnDone.Visible = true;
        }
        else
        {
            cboBomMove.Visible = false;
            btnDone.Visible = false;
        }
    }

    protected void btnDone_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlBom.SelectedValue))
        {
            Master.ShowError("Select Isometric and  Bom");
            ddlIsometric.Focus();
            ddlBom.Focus();
            return;
        }

        string sec_key = WebTools.GetExpr("SEC_KEY", "PIP_BOM", " WHERE BOM_ID=" + ddlBom.SelectedValue);
        string mat_id = WebTools.GetExpr("MAT_ID", "PIP_BOM", " WHERE BOM_ID=" + ddlBom.SelectedValue);
        string test = WebTools.GetExpr("SEC_KEY", "PIP_BOM", " WHERE SPL_ID=" + cboBomMove.SelectedValue.ToString() +
            " AND MAT_ID=" + mat_id +
            " AND SEC_KEY=" + sec_key);

        if (test != "")
        {
            General_Functions.ExeSql("UPDATE PIP_BOM SET SEC_KEY=SEC_KEY+1 WHERE BOM_ID=" + ddlBom.SelectedValue);
        }
        General_Functions.ExeSql("UPDATE PIP_BOM SET SPL_ID=" + cboBomMove.SelectedValue.ToString() +
            " WHERE BOM_ID=" + ddlBom.SelectedValue);
        Master.ShowMessage("BOM item moved to " + cboBomMove.SelectedText.ToString());

        cboBomMove.Visible = false;
        btnDone.Visible = false;
    }

    protected void JointRadGrid_DeleteCommand(object sender, GridCommandEventArgs e)
    {

        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");
        if (tpk_lock == "Y")
        {
            Master.ShowWarn("Access Denied. Spool Locked in Testpack.");
            e.Canceled = true;
            return;
        }

        if (!WebTools.UserInRole("PIP_WIC_DELETE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
        }

    }

    protected void JointRadGrid_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            string fitup_rep_no = item["FITUP_REP_NO"].Text;
            string filename = fitup_rep_no + ".pdf";
            string pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'FITUP'");
            string pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'FITUP'");

            string full_pdf_path = pdf_url + filename;
            string full_asp_path = pdf_asp_url + filename;
            Label pdf_label = (Label)item.FindControl("pdf");

            if (File.Exists(full_pdf_path))
            {
                string url = "<a title='Receive PDF' href='" + full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("fituppdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }


            string weld_rep_no = item["WELD_REP_NO"].Text;
            string w_filename = weld_rep_no + ".pdf";
            string w_pdf_url = WebTools.GetExpr("PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'WELDING'");
            string w_pdf_asp_url = WebTools.GetExpr("ASP_PATH", "DIR_OBJECTS", " PROJECT_ID = '" + Session["PROJECT_ID"].ToString() + "' AND DIR_OBJ = 'WELDING'");

            string w_full_pdf_path = w_pdf_url + w_filename;
            string w_full_asp_path = w_pdf_asp_url + w_filename;
            Label weld_pdf_label = (Label)item.FindControl("weldpdf");

            if (File.Exists(w_full_pdf_path))
            {
                string url = "<a title='Receive PDF' href='" + w_full_asp_path + "' target='_blank'><img src='../Images/New-Icons/pdf.png'/></a>";
                Label pdficon = (Label)item.FindControl("weldpdf");
                if (pdficon != null)
                    pdficon.Text = url;
            }
        }
    }

    protected void BomRadGrid_EditCommand(object sender, GridCommandEventArgs e)
    {
        if (!WebTools.UserInRole("MM_UPDATE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
        }

        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied. Spool Locked in Testpack.");
        }
    }

    protected void BomRadGrid_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied. Spool Locked in Testpack.");
            return;
        }

        if (!WebTools.UserInRole("MM_DELETE"))
        {
            e.Canceled = true;
            Master.ShowWarn("Access Denied!");
            return;
        }

        GridDataItem item = e.Item as GridDataItem;
        string strId = item.GetDataKeyValue("BOM_ID").ToString();
        try
        {
            WebTools.ExecNonQuery("DELETE PIP_SUPP_BOM WHERE BOM_ID=" + strId);
            WebTools.ExecNonQuery("DELETE PIP_BOM WHERE BOM_ID=" + strId);
        }
        catch (Exception ex)
        {
            e.Canceled = true;
            Master.ShowError(ex.Message);
        }

    }
    protected void Mat_Code1Link_Click(object sender, EventArgs e)
    {
        LinkButton link = (LinkButton)sender;
        //if (HeatNoUpdate.Visible)
        //{
        //    UpdateHeatNoTextBox();
        //}
        //mASTER

        string descr = "<B>" + link.Text + "</B>     : ";
        descr += WebTools.GetExpr("MAT_DESCR", "AMOGH.PIP_MAT_STOCK", " MAT_CODE1='" + link.Text + "'");
        if (descr.Length > 0)
        {
            Master.ShowMessage(descr);
        }
    }


    protected void RadBulkImport_ItemClick(object sender, RadMenuEventArgs e)
    {
        if (RadBulkImport.SelectedValue == "0")
        {
            return;
        }
        Response.Redirect("~/Isome/BulkReportImport.aspx?IMPORT_ID=" + RadBulkImport.SelectedValue);
    }

    protected void btnWeldingDt_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue))
        {
            Master.ShowError("Select Isometric and Joint...");
            ddlIsometric.Focus();
            ddlJoint.Focus();

        }
        else
        {
            AddModalPopupButtonClick("~/WeldingInspec/PipingDWR_Popup.aspx?JOINT_ID=" + ddlJoint.SelectedValue, btnWeldingDt.ClientID, 550, 1100);

        }

    }

    protected void btnNdtDt_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue))
        {
            Master.ShowError("Select Isometric and Joint...");
            ddlIsometric.Focus();
            ddlJoint.Focus();

        }
        else
        {
            AddModalPopupButtonClick("~/Isome/SpoolJoints_NDE.aspx?JOINT_ID=" + ddlJoint.SelectedValue, btnNdtDt.ClientID, 550, 750);

        }
    }

    protected void BtnJntMove_Click(object sender, EventArgs e)
    {

        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");
        if (tpk_lock == "Y")
        {
            Master.ShowError("Access denied. Spool Locked in Testpack.");
            return;
        }

        if (!WebTools.UserInRole("PIP_WIC_UPDATE"))
        {
            Master.ShowMessage("Access denied!");
            return;
        }
        if (string.IsNullOrEmpty(ddlJoint.SelectedValue))
        {
            Master.ShowMessage("Select joint number!");
            return;
        }
        if (!cboJointMove.Visible)
        {
            cboJointMove.Visible = true;
            btnJntDone.Visible = true;
        }
        else
        {
            cboJointMove.Visible = false;
            btnJntDone.Visible = false;
        }
    }

    protected void btnJntDone_Click(object sender, EventArgs e)
    {
        if (cboJointMove.SelectedValue.ToString() == "-1")
        {
            return;
        }
        General_Functions.ExeSql("UPDATE PIP_SPOOL_JOINTS SET SPL_ID=" + cboJointMove.SelectedValue.ToString() +
            " WHERE JOINT_ID=" + ddlJoint.SelectedValue);
        cboJointMove.Visible = false;
        btnJntDone.Visible = false;
        Master.ShowMessage("Joint moved to " + cboJointMove.SelectedText.ToString());

    }

    protected void btnSetItemCode_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue))
        {
            Master.ShowError("Select Isometric and Joint...");
            ddlIsometric.Focus();
            ddlJoint.Focus();

        }
        else
        {
            AddModalPopupButtonClick("~/Isome/SetJointItems.aspx?JOINT_ID=" + ddlJoint.SelectedValue, btnSetItemCode.ClientID, 550, 750);

        }

    }

    protected void btnSplDelete_Click(object sender, EventArgs e)
    {
        string tpk_lock = WebTools.GetExpr("TPK_LOCK", "PIP_ISOMETRIC", " WHERE ISO_ID = '" + ddlIsometric.SelectedValue + "'");

        if (tpk_lock == "Y")
        {
            Master.ShowWarn("Access Denied. Spool locked in Testpack.");
            return;
        }

        if (!WebTools.UserInRole("PIP_DCS_DELETE"))
        {
            Master.ShowWarn("Access Denied!");
            return;
        }
        if (string.IsNullOrEmpty(ddlSpool.SelectedValue))
        {
            Master.ShowMessage("Select the spool.");
            ddlSpool.Focus();

            return;

        }

        btnSplYes.Visible = true;
        btnSplNo.Visible = true;
        Master.ShowMessage("Proceed delete the spool?");
    }

    protected void btnSplYes_Click(object sender, EventArgs e)
    {
        try
        {
            // delete dependencies 
            WebTools.ExeSql("DELETE FROM PIP_SPOOL_PDF WHERE SPL_ID=" + ddlSpool.SelectedValue);
            WebTools.ExeSql("DELETE FROM PIP_SPOOL WHERE SPL_ID=" + ddlSpool.SelectedValue);
            Master.ShowMessage("Spool deleted.");

        }
        catch (Exception ex)
        {
            Master.ShowWarn(ex.Message);
        }
    }



    protected void btnNdtJointAdd_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(RadComNdeReq.SelectedValue))
        {
            Master.ShowError("Select NDT Request");
            RadComNdeReq.Focus();
        }
        else
        {
            string nde_type_id = WebTools.GetExpr("NDE_TYPE_ID", "PIP_NDE_REQUEST", " NDE_REQ_ID=" + RadComNdeReq.SelectedValue);
            string sc_id = WebTools.GetExpr("SC_ID", "PIP_NDE_REQUEST", " NDE_REQ_ID=" + RadComNdeReq.SelectedValue);
            AddModalPopupButtonClick("~/PipingNDT/NDE_RequestJointsNew.aspx?NDE_REQ_ID=" + RadComNdeReq.SelectedValue + "&NDE_TYPE_ID="
                      + nde_type_id + "&SC_ID=" + sc_id, btnNdtJointAdd.ClientID, 450, 550);
        }

    }



    protected void DeleteNdtJoint_Click(object sender, EventArgs e)
    {
        string query = "";
        try
        {
            if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue)
              || string.IsNullOrEmpty(RadComJointActivity.SelectedValue) || string.IsNullOrEmpty(RadComNdeReq.SelectedValue))
            {
                Master.ShowError("Select Isometric , Joint & Activity Request");
                ddlIsometric.Focus();
                ddlJoint.Focus();
                RadComJointActivity.Focus();
                RadComNdeReq.Focus();
            }
            else
            {
                if (!WebTools.UserInRole("PIP_WIC_DELETE"))
                {
                    Master.ShowWarn("Access Denied!");
                    return;
                }

                query = "DELETE FROM PIP_NDE_REQUEST_JOINTS  WHERE JOINT_ID = " + ddlJoint.SelectedValue + " AND NDE_REQ_ID = " + RadComNdeReq.SelectedValue;

                WebTools.ExeSql(query);
                Master.ShowSuccess("Deleted..");
                NdeDetailsView.DataBind();
            }
        }
        catch (Exception ex)
        {

            Master.ShowError(ex.ToString());

        }

    }

    protected void btnNdtUpdate_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue)
            || string.IsNullOrEmpty(RadComNdeReq.SelectedValue))
        {
            Master.ShowError("Select Isometric , Joint & NDT request");
            ddlIsometric.Focus();
            ddlJoint.Focus();
            RadComNdeReq.Focus();

        }
        else
        {
            string ndt_avl = WebTools.GetExpr("NDE_ITEM_ID", "PIP_NDE_REQUEST_JOINTS", " JOINT_ID=" + ddlJoint.SelectedValue + " AND NDE_REQ_ID="
                + RadComNdeReq.SelectedValue);
            if (ndt_avl.Length > 0)
            {
                AddModalPopupButtonClick("~/PipingNDT/NDE_StatusUpdate.aspx?JOINT_ID=" + ddlJoint.SelectedValue + "&NDE_REQ_ID="
                + RadComNdeReq.SelectedValue, btnSetItemCode.ClientID, 550, 750);
            }
            else
            {
                Master.ShowError("Joint not found in selected Request");
            }


        }

    }

    protected void NdtSegments_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue) || string.IsNullOrEmpty(ddlJoint.SelectedValue)
             || string.IsNullOrEmpty(RadComNdeReq.SelectedValue))
        {
            Master.ShowError("Select Isometric , Joint & NDT request");
            ddlIsometric.Focus();
            ddlJoint.Focus();
            RadComNdeReq.Focus();

        }
        else
        {
            string ndt_avl = WebTools.GetExpr("NDE_ITEM_ID", "PIP_NDE_REQUEST_JOINTS", " JOINT_ID=" + ddlJoint.SelectedValue + " AND NDE_REQ_ID="
                   + RadComNdeReq.SelectedValue);
            if (ndt_avl.Length > 0)
            {
                AddModalPopupButtonClick("~/PipingNDT/NDE_StatusSegment.aspx?JOINT_ID=" + ddlJoint.SelectedValue + "&REQ_ID="
                + RadComNdeReq.SelectedValue, btnSetItemCode.ClientID, 550, 750);
            }
            else
            {
                Master.ShowError("Joint not found in selected Request");
            }
        }

    }

    protected void btnIsoMto_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(ddlIsometric.SelectedValue))
        {
            Master.ShowError("Select Isometric to view details of Iso");
            ddlIsometric.Focus();
        }
        else
        {
            AddModalPopupButtonClick("~/Isome/IsomeIndex_MTO.aspx?ISO_ID=" + ddlIsometric.SelectedValue, ImageIsoButtonDetails.ClientID, 550, 850);

        }
    }

    public void UpdateSpoolLabels()
    {
        string jc_number = WebTools.GetExpr("WO_NAME", "PIP_WORK_ORD ", " WHERE WO_ID IN (SELECT WO_ID FROM PIP_WORK_ORD_SPOOL WHERE SPL_ID='"
                      + ddlSpool.SelectedValue + "' ) ");
        string paint_number = WebTools.GetExpr("PNT_REQ_NO", "PIP_PAINTING_SPL ", " WHERE SPL_PNT_ID IN (SELECT SPL_PNT_ID FROM PIP_PAINTING_SPL_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "' ) ");
        string irn_before = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS ", " WHERE TRANS_ID IN (SELECT TRANS_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "' AND CAT_ID='10') ");
        string irn_after = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS ", " WHERE TRANS_ID IN (SELECT TRANS_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "' AND CAT_ID='16') ");
        string srn = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS ", " WHERE TRANS_ID IN (SELECT TRANS_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "' AND CAT_ID='8') ");
        string transfer = WebTools.GetConcatinateExpr("TRANS_NO", "PIP_SPL_TRANSFER ", " WHERE TRANS_ID IN (SELECT TRANS_ID FROM PIP_SPL_TRANSFER_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "') ");
        string receive = WebTools.GetConcatinateExpr("RCV_NO", "PIP_SPL_RECEIVE ", " WHERE RCV_ID IN (SELECT RCV_ID FROM PIP_SPL_RECEIVE_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "') ");
        string site_insp = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS ", " WHERE TRANS_ID IN (SELECT TRANS_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "' AND CAT_ID='5') ");
        string issue_field = WebTools.GetExpr("SER_NO", "PIP_SPOOL_TRANS ", " WHERE TRANS_ID IN (SELECT TRANS_ID FROM PIP_SPOOL_TRANS_DETAIL WHERE SPL_ID='"
                    + ddlSpool.SelectedValue + "' AND CAT_ID='12') ");


        txtExist.Text = "<table> <th>Spool Status </th>" +
                        "<tr><td><font color=#63ac39>Jc Number : </font></td><td><font color=#ff4242>" + jc_number.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>Paint Number     : </font></td><td><font color=#ff4242>" + paint_number.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>IRN Before Paint : </font></td><td><font color=#ff4242>" + irn_before.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>IRN after Paint  : </font></td><td><font color=#ff4242>" + irn_after.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>SRN Number       : </font></td><td><font color=#ff4242>" + srn.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>Transfer Number  : </font></td><td><font color=#ff4242>" + transfer.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>Receive Number   : </font></td><td><font color=#ff4242>" + receive.Replace(",", "<br/>") + " </font></td></tr>" +
                        "<tr><td><font color=#63ac39>Site Inspection  : </font></td><td><font color=#ff4242>" + site_insp.Replace(",", "<br/>") + "</font></td></tr>" +
                        "<tr><td><font color=#63ac39>Issue To Field   : </font></td><td><font color=#ff4242>" + issue_field.Replace(",", "<br/>") + "</font></td></tr></table>";

    }
}
