using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SpoolMove_SpoolCoatingTypes : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Master.HeadingMessage("Spool Coating Types");
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        EntryTable.Visible = EntryTable.Visible ? false : true;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsGalvJobcardTableAdapters.PIP_COATING_TYPETableAdapter coating = new dsGalvJobcardTableAdapters.PIP_COATING_TYPETableAdapter();
            string coat_type_id = WebTools.DMaxText("COATING_TYPE_ID", "PIP_COATING_TYPE", " WHERE 1=1");

            if (string.IsNullOrEmpty(coat_type_id))
                coat_type_id = "1";
            else
                coat_type_id = (decimal.Parse(coat_type_id) + 1).ToString();

            coating.InsertQuery(decimal.Parse(coat_type_id), txtCoatingType.Text);
            Master.show_success("Item Added Successfully.");
            gridItems.Rebind();
        }
        catch (Exception ex)
        {
            Master.show_error(ex.Message);
        }
    }
}