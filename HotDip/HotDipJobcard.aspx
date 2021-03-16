<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="HotDipJobcard.aspx.cs" Inherits="HotDip_HotDipJobcard" Title="Hot Dip" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSCR_PDF1" runat="server" Text="SCR PDF" Width="90" Skin="Sunset" OnClick="btnSCR_PDF1_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSCRFrom" runat="server" EmptyMessage="From" Visible="false" Width="80"></telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSCRTo" runat="server" EmptyMessage="To" Visible="false" Width="80"></telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnSCR_PDF" runat="server" Text="Create Zip" Width="80"
                        OnClick="btnSCR_PDF_Click" Skin="Sunset" Visible="false">
                    </telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px" AutoPostBack="True"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:GridView ID="LooseIssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="JC_ID" DataSourceID="LooseIssueDataSource" SkinID="GridViewSkin"
            PageSize="20" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="LooseIssueGridView_DataBound">
            <Columns>
                <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True"
                    CancelImageUrl="~/Images/icon-cancel.gif" EditImageUrl="~/Images/icon-edit.gif"
                    ShowEditButton="True" UpdateImageUrl="~/Images/icon-save.gif">
                    <ItemStyle Width="50px" />
                </asp:CommandField>
                <asp:BoundField DataField="JC_NO" HeaderText="Jobcard No" SortExpression="JC_NO" />
                <asp:BoundField DataField="JC_DATE" HeaderText="Issue Date" SortExpression="JC_DATE"
                    DataFormatString="{0:dd-MMM-yyyy}" ApplyFormatInEditMode="true" HtmlEncode="false" />
                <asp:TemplateField HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>' Width="150px">
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
            </Columns>

            <EmptyDataTemplate>
                No Jobcard!
            </EmptyDataTemplate>
        </asp:GridView>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New" Width="80" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSpools" runat="server" Text="Spools" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
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
                    <asp:DropDownList ID="ddReports" runat="server" Width="250px">
                        <asp:ListItem Selected="True" Value="1" Text="Hot Dip Jobcard Spool List"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:ObjectDataSource ID="LooseIssueDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsHotDipTableAdapters.VIEW_HOT_DIP_JOBCARDTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="JC_NO" Type="String" />
            <asp:Parameter Name="JC_DATE" Type="DateTime" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR
WHERE (PROJ_ID = :PROJECT_ID)
 ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>