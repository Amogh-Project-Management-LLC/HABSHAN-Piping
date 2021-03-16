<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_Mat.aspx.cs" Inherits="Erection_MatIssueLoose" Title="Additional Mat Issue" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New" Width="80" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPipeRemain" runat="server" Text="Remain" Width="80" OnClick="btnPipeRemain_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Bulk" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddReports" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Value="11" Text="Bulk Material Report" Selected="true" />
                            <telerik:DropDownListItem Value="12" Text="Use Remains Report" />
                            <telerik:DropDownListItem Value="12.1" Text="Bill of Materials Report" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Show Report" Width="110" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" AutoPostBack="True" EmptyMessage="Search Here"
                        OnTextChanged="txtSearch_TextChanged" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top:3px">
        <telerik:RadGrid ID="IssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="issueDataSource" PageSize="20" Width="100%" SkinID="GridViewSkin"
            OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="IssueGridView_DataBound"
            DataKeyNames="ADD_ISSUE_ID">
            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
            <MasterTableView DataKeyNames="ADD_ISSUE_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="20" />
                    </telerik:GridEditCommandColumn>                    
                    <telerik:GridTemplateColumn HeaderText="Issue No" SortExpression="ISSUE_NO">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ISSUE_NO") %>' Width="96px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("ISSUE_NO") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Scope" SortExpression="MAT_SCOPE_CODE">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBoxMatScope" runat="server" Text='<%# Bind("MAT_SCOPE_CODE") %>' Width="50px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="LabelMatScope" runat="server" Text='<%# Bind("MAT_SCOPE_CODE") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Issue Date" SortExpression="ISSUE_DATE">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'
                            Width="93px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Issued by" SortExpression="ISSUE_BY">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ISSUE_BY") %>' Width="88px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("ISSUE_BY") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Subcon" SortExpression="SUB_CON_NAME">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                            Width="97px">
                            <asp:ListItem Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("SUB_CON_NAME") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Category" SortExpression="CATEGORY">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="catDataSource"
                            DataTextField="CATEGORY" DataValueField="CAT_ID" SelectedValue='<%# Bind("CAT_ID") %>'
                            Width="104px">
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("CATEGORY") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Store" SortExpression="STORE_NAME">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                            DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                            Width="102px">
                            <asp:ListItem Selected="True"></asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("STORE_NAME") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="Remarks" SortExpression="REMARKS">
                        <edititemtemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("REMARKS") %>' Width="161px"></asp:TextBox>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro; margin-top:3px">
        <table>
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
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR
WHERE PROJ_ID = :PROJECT_ID
ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="issueDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.PIP_MAT_ISUE_ADDTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="ISSUE_BY" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="CAT_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_SCOPE_CODE" Type="String" />
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="catDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "CAT_ID", "CATEGORY" FROM "PIP_MAT_ISSUE_ADD_CAT"'></asp:SqlDataSource>
</asp:Content>
