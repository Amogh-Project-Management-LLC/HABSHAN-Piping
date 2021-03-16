using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class PopupMasterPage : System.Web.UI.MasterPage
{
    public enum WarningType { Success, Danger, Info, Warning };
    protected void Page_Load(object sender, EventArgs e)
    {
        string project_id = Session["PROJECT_ID"].ToString();
        string username = Session["USER_NAME"].ToString();

        if (username.Length == 0)
        {
            ShowWarn("Session has been Expired");
        }
    }

    public void show_success(string Message)
    {
        //MessagePanel.CssClass = "success";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Success);
    }

    public void show_error(string Message)
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
    public void show_info(string Message)
    {
        //MessagePanel.CssClass = "info";
        //MsgLabel.Text = Message;
        //MessagePanel.Visible = true;
        ShowPopupMessage(Message, WarningType.Info);
    }
    public void ShowWarn(string Message)
    {
      ShowPopupMessage(Message, WarningType.Warning);
    }
    public void HeadingMessage(string Message)
    {
        HeadingMessageLabel.Text = Message;
        heading_div.Visible = true;
    }
    public void ShowAccessDenied()
    {
        ShowWarn("Access Denied!");
    }
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
        RadWindowManager2.Windows.Add(newWindow);
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
    public void ShowPopupMessage(string Message, WarningType type)
    {
        labelMessage.Text = "<strong>" + type.ToString().Replace("Danger", "Error") + "! </strong> <span>" + Message + "</span>";
        MessagePanelID.CssClass = string.Format("alert fade in alert-{0} alert-dismissable", type.ToString().ToLower());
        MessagePanelID.Attributes.Add("role", "alert");
        MessagePanelID.Visible = true;
    }
}