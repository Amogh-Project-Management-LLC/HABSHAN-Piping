<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mat_Transf.aspx.cs" Inherits="Erection_MatIssueLoose" Title="Material Transfer" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= IssueGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=IssueGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>

    <div>
        <table style="width: 100%; background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="Register" Width="80" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Materials" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged"
                        EmptyMessage="Search Here" Width="200px" AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadDropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="140px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div style="margin-top:3px">
        <telerik:RadGrid ID="IssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="True"
            DataSourceID="issueDataSource" PageSize="30" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="IssueGridView_DataBound" DataKeyNames="TRANSF_ID">
            <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
            <MasterTableView DataKeyNames="TRANSF_ID" EditMode="InPlace" AllowAutomaticUpdates="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Item?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>
                    
                    <telerik:GridBoundColumn DataField="TRANSF_NO" HeaderText="Transfer Number" SortExpression="TRANSF_NO" />
                    <telerik:GridBoundColumn DataField="CREATE_DATE" HeaderText="Create Date" SortExpression="CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}"/>
                    <telerik:GridBoundColumn DataField="CREATE_BY" HeaderText="Create By" SortExpression="CREATE_BY" />
                    <telerik:GridTemplateColumn HeaderText="From Store" SortExpression="A_STORE">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                            DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("A_STORE_ID") %>'
                            Width="100px">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("A_STORE") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="To Store" SortExpression="B_STORE">
                        <edititemtemplate>
                        <asp:DropDownList ID="DropDownList12" runat="server" AppendDataBoundItems="True"
                            DataSourceID="storeDataSource" DataTextField="STORE_NAME" DataValueField="STORE_ID"
                            SelectedValue='<%# Bind("B_STORE_ID") %>' Width="100px">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </edititemtemplate>
                        <itemtemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("B_STORE") %>'></asp:Label>
                    </itemtemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="CAT_NAME" ReadOnly="true" HeaderText="Transfer Type" SortExpression="CAT_NAME" />
                    <telerik:GridBoundColumn DataField="DOC_REF_NO" ReadOnly="true" HeaderText="Reference No" SortExpression="DOC_REF_NO" />
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="issueDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.PIP_MAT_TRANSFTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TRANSF_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="SEARCH" PropertyName="Text" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="TRANSF_NO" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
            <asp:Parameter Name="A_STORE_ID" Type="Decimal" />
            <asp:Parameter Name="B_STORE_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_SCOPE_CODE" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_TRANSF_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>
