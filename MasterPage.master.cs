using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web;
using System.Configuration;
using System.Web.Configuration;


public partial class Amogh_MasterPage : System.Web.UI.MasterPage
{
    private object webtools;
    public enum WarningType { Success, Danger, Info, Warning };
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            string project_id = Session["PROJECT_ID"].ToString();
            string username = Session["USER_NAME"].ToString();
            
            if (username.Length == 0)
            {
                //string url = "~/LoginPage.aspx?RetUrl=" + Request.Url.AbsolutePath.ToString();
                string url = "~/LoginPage.aspx";
                Response.Redirect(url);
            }

            string id = WebTools.GetExpr("HIDE_ID","USERS",  " USER_NAME ='" + Session["USER_NAME"] + "'");
            string[] hide_id = id.Split(',');

            foreach (string control in hide_id)
            {

                RadPanelItem selectedItem = RadPanelBar1.FindItemByValue(control);
                if (selectedItem != null)
                {
                    selectedItem.Visible = false;
                }

            }
            //if (project_id == "" || project_id == null)
            //{
            //    Session["PROJECT_ID"] = Request.Cookies["PROJECT_ID"].Value;
            //    Session["PROJECT"] = Request.Cookies["PROJECT"].Value;
            //    Session["JOB_CODE"] = Request.Cookies["JOB_CODE"].Value;
            //    Session["CONNECT_AS"] = Request.Cookies["CONNECT_AS"].Value;
            //    Session["CONNECT"] = Request.Cookies["CONNECT"].Value;
            //}

            projectLabel.Text = Session["PROJECT"].ToString();

            UserNameLablel.Text = Session["USER_NAME"].ToString();
            //UserNameLablel.Text = users.Count.ToString();

            //Search
            //Session["MASTER_SEARCH"] = string.Empty;
            if (Session["ACCOUNT_PIC_URL"].ToString() != string.Empty)
            {
                ImageButtonUserInfo.Height = Unit.Pixel(30);
                //ImageButtonUserInfo.Width = Unit.Pixel(30);
                ImageButtonUserInfo.BorderStyle = BorderStyle.Solid;
                ImageButtonUserInfo.BorderWidth = Unit.Pixel(1);
                ImageButtonUserInfo.BorderColor = System.Drawing.Color.Gray;
                ImageButtonUserInfo.ImageUrl = Session["ACCOUNT_PIC_URL"].ToString();
            }

            foreach (DropDownListItem item in ddLang.Items)
            {
                if (Session["lang"].ToString().Contains(item.Value.ToString()))
                {
                    ddLang.SelectedIndex = item.Index;
                    //item.Selected = true;
                    break;
                }
            }
        }
    }

    public string HeadingMessage
    {
        set { headingMessageLabel.Text = value; }
        get { return headingMessageLabel.Text; }
    }

    public string RadGridList
    {
        set { RadGridListHiddenField.Value = value; }
        get { return RadGridListHiddenField.Value.ToString(); }
    }

    public string AspGridList
    {
        set { AspGridListHiddenField.Value = value; }
        get { return AspGridListHiddenField.Value.ToString(); }
    }
    public string ButtonList
    {
        set { ButtonListHiddenField.Value = value; }
        get { return ButtonListHiddenField.Value.ToString(); }
    }
    
    //Add Modal Popup
    public void AddModalPopup(string nav_url, string opener_client_Id, int height, int width)
    {
        RadWindow newWindow = new RadWindow();
        newWindow.NavigateUrl = nav_url;
        newWindow.Height = Unit.Pixel(height);
        newWindow.Width = Unit.Pixel(width);
        newWindow.VisibleOnPageLoad = false;
        newWindow.OpenerElementID = opener_client_Id;
        newWindow.OnClientClose = "Rebind_Parent";
        newWindow.VisibleStatusbar = false;
        //newWindow.Modal = true;
        RadWindowManager1.Windows.Add(newWindow);
    }

    protected void LogoutButton_Click(object sender, EventArgs e)
    {
        Session["USER_NAME"] = string.Empty;
        Session["ACCOUNT_PIC_URL"] = string.Empty;

        //var session = sender as HttpSessionState;
        var users = Application.Get("Users") as UsersCollection;
        users.Remove(Session.SessionID);
        Application.Set("Users", users); // update it

        Response.Redirect("~/LoginPage.aspx");


    }

    //public void DisplayMessage(Control page, string msg)
    //{
    //    string myScript = String.Format("alert('{0}');", msg);
    //    ScriptManager.RegisterStartupScript(page, page.GetType(), "MyScript", myScript, true);
    //}

    protected void ImageButtonLogout_Click(object sender, ImageClickEventArgs e)
    {
        Session["USER_NAME"] = string.Empty;
        Session["ACCOUNT_PIC_URL"] = string.Empty;
        Response.Redirect("~/LoginPage.aspx");
    }

    protected void ImageButtonSetting_Click(object sender, ImageClickEventArgs e)
    {
        if (WebTools.IsAdminUser(Session["USER_NAME"].ToString()))
        {
            Response.Redirect("~/Admin/Default.aspx");
        }
    }

    //Notification-Box
    public void notify_success(string Message)
    {
        //MessagePanel.CssClass = "success";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Success);
    }

    public void notify_error(string Message)
    {
        if (Message.Contains("unique constraint"))
        {
            Message = "Duplicate Error!";
        }
        //MessagePanel.CssClass = "error";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Danger);
    }

    public void notify_info(string Message)
    {
        //MessagePanel.CssClass = "info";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Info);
    }

    public void ShowWarn(string Message)
    {
        //MessagePanel.CssClass = "error";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        //RadWindowManager1.RadAlert(msg.Trim(), 430, 180, "Error", "", "../Images/icons/icon-error.png");
        ShowPopupMessage(Message, WarningType.Danger);
    }
    public void ShowWarnNew(string Message)
    {
      ShowPopupMessage(Message, WarningType.Warning);
    }

    public void ShowMessage(string Message)
    {
        //MessagePanel.CssClass = "info";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        //RadWindowManager1.RadAlert(msg.Trim(), 430, 180, "Information", "", "../Images/icons/icon-information.png");
        ShowPopupMessage(Message, WarningType.Info);
    }

    public void ShowError(string Message)
    {
        if (Message.Contains("unique constraint"))
        {
            Message = "Duplicate Error!";
        }
        //MessagePanel.CssClass = "error";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Danger);
    }

    public void ShowSuccess(string Message)
    {
        //MessagePanel.CssClass = "success";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Success);
    }

    public void ShowAccessDenied()
    {
        ShowError("Access Denied!");
    }

    protected void ImageButtonUserInfo_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Admin/User_Info.aspx");
    }

    protected void ImageButtonMaterialCatalog_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Material/MaterialStock.aspx");
    }
    protected void ImageButtonReports_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/BasicReports/Report_List.aspx");
    }
    protected void ImageButtonCharts_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/BasicReports/AmoghGraphs.aspx");
    }
    protected void ddLang_DataBound(object sender, EventArgs e)
    {
        
    }
    protected void ddLang_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        var nameValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
        string new_lang = ddLang.SelectedItem.Value.ToString();

        if (nameValues.ToString().Contains("lang="))
        {
            nameValues.Set("lang", new_lang);
        }
        else
        {
            nameValues.Add("lang", new_lang);
        }
        string url = Request.Url.AbsolutePath;
        string updatedQueryString = "?" + nameValues.ToString();
        Response.Redirect(url + updatedQueryString);
    }

    protected void ImageButtonUpdates_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Utilities/AmoghUpdates.aspx");
    }

    protected void SubconWiseDashBoard_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Home/DashboardAll.aspx");
    }
    protected void FlangeSubconWiseDashBoard_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Home/FlangeDashboardAll.aspx");
    }

    protected void ImageButtonEntry_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Home/EntryPage.aspx");
    }

    protected void RadSkinManager1_Load(object sender, EventArgs e)
    {
       (sender as RadSkinManager).Skin = "Office2007";
       (sender as RadSkinManager).GetSkinChooser().Height = Unit.Pixel(200);
    }

    protected void RadSkinManager1_PreRender(object sender, EventArgs e)
    {
        RadComboBox skinChooser = RadSkinManager1.FindControl("SkinChooser") as RadComboBox;
        int i = 0;
        while (i < skinChooser.Items.Count)
        {
            if (skinChooser.Items[i].Text == "Material")
            {
                skinChooser.Items.Remove(skinChooser.Items[i]);
            }
            i++;
            
        }
    }
    public void ShowPopupMessage(string Message, WarningType type)
    {
        labelMessage.Text = "<strong>"+ type.ToString().Replace("Danger", "Error") + "! </strong> <span>" + Message+ "</span><hr><span>Press Esc Button To Close</span>";
        MessagePanelID.CssClass = string.Format("alert fade in alert-{0} alert-dismissable fade show", type.ToString().ToLower());
        MessagePanelID.Attributes.Add("role", "alert");
        MessagePanelID.Visible = true;
    }
}
