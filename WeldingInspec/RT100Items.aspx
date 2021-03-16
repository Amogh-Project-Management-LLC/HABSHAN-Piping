<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="RT100Items.aspx.cs" Inherits="WeldingInspec_JointsPaintItems"
    Title="Joints Painting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80" OnClick="btnEntry_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <asp:GridView ID="jointsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="ItemsDataSource" PageSize="18" Width="100%" SkinID="GridViewSkin"
            DataKeyNames="JOINT_ID,LIST_ID" OnRowUpdating="jointsGridView_RowUpdating"
            OnRowEditing="jointsGridView_RowEditing">
            <Columns>
                <asp:CommandField ShowSelectButton="True" ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif"
                    UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="30px" />
                </asp:CommandField>
                <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                    ReadOnly="True" />
                <asp:BoundField DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" ReadOnly="True" />
                <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" ReadOnly="True" />
                <asp:BoundField DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" ReadOnly="True" />
                <asp:BoundField DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Weld Date"
                    HtmlEncode="False" SortExpression="WELD_DATE" ReadOnly="True" ShowHeader="False" />
            </Columns>
        </asp:GridView>
    </div>

    <div>
        <table style="width: 100%; background-color: whitesmoke">
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtIsome" runat="server" AutoPostBack="True" OnTextChanged="txtIsome_TextChanged"
                        EmptyMessage="Isometric No" Visible="False" Width="250px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="cboNewJoint" runat="server" DataSourceID="newjointDataSource"
                        DataTextField="JNT_TITLE" DataValueField="JOINT_ID" Visible="False" Width="350px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddJoint" runat="server" Text="Save" Width="80" OnClick="btnAddJoint_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="ItemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsRT100TableAdapters.VIEW_RT_100_DETAILTableAdapter"
        DeleteMethod="DeleteQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="LIST_ID" QueryStringField="LIST_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_LIST_ID" Type="Decimal" />
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="newjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, JNT_TITLE FROM VIEW_JOINTS_SIMPLE_WELDING
WHERE (ISO_TITLE1 = :ISO_TITLE1)
AND (PROJ_ID = :PROJECT_ID)
AND (WELD_DATE IS NOT NULL)
ORDER BY ISO_ID, FNC_JNT_NO_DEC(JOINT_NO)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="~" Name="ISO_TITLE1" PropertyName="Text" />
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>