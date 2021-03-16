<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatIssueLoose.aspx.cs" Inherits="MatIssueLoose" Title="Site Job Card" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= LooseIssueGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=LooseIssueGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 230 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnNewIssue" runat="server" Text="Register" Width="84px" OnClick="btnNewIssue_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnViewMats" runat="server" OnClick="btnViewMats_Click" Text="Materials"
                                Width="81px" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSpools" runat="server" Text="Spools" Width="81px" OnClick="btnSpools_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnJoints" runat="server" Text="Joints" Width="81px" OnClick="btnJoints_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnUpdate" runat="server" Text="Update" Width="81px" OnClick="btnUpdate_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnImportMaterial" runat="server" Text="Import Material" Width="140px" OnClick="btnImportMaterial_Click">
                                <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                            </telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnImportJoints" runat="server" Text="Import Joints" Width="140px" OnClick="btnImportJoints_Click">
                                <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                            </telerik:RadButton>
                        </td>
                        <td style="width: 100%; text-align: right">
                            <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px"
                                AutoPostBack="True">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="LooseIssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="true"
                    CssClass="DataWebControlStyle" DataKeyNames="JC_ID" DataSourceID="LooseIssueDataSource"
                    PageSize="15" Width="100%" OnRowEditing="LooseIssueGridView_RowEditing" OnDataBound="LooseIssueGridView_DataBound" OnRowDeleting="LooseIssueGridView_RowDeleting">
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
                    <MasterTableView DataKeyNames="JC_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this Job Card?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="SITE JC NO" SortExpression="ISSUE_NO" />
                            <telerik:GridBoundColumn DataField="PCWBS" HeaderText="PCWBS" SortExpression="PCWBS" />
                            <telerik:GridTemplateColumn HeaderText="Mat Type" SortExpression="MAT_TYPE">
                                <EditItemTemplate>
                                    <telerik:RadTextBox ID="txtmainMat" runat="server" Text='<%# Bind("MAT_TYPE") %>'></telerik:RadTextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblMainMat" runat="server" Text='<%# Bind("MAT_TYPE") %>' Width="126px"></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="JC_TYPE" HeaderText="JC TYPE" SortExpression="JC_TYPE" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="JC_REV" HeaderText="JC REV" SortExpression="JC_REV" />
                            <telerik:GridBoundColumn DataField="REV_DATE" HeaderText="REV DATE" SortExpression="REV_DATE" ReadOnly="true"
                                DataFormatString="{0:dd-MMM-yyyy}" />
                            <telerik:GridTemplateColumn HeaderText="ISSUE DATE" SortExpression="ISSUE_DATE" ReadOnly="true">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtIssueDate" runat="server" SelectedDate='<%# Bind("ISSUE_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'
                                        Width="82px"></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_BY" HeaderText="ISSUED BY" SortExpression="ISSUE_BY" />
                            <telerik:GridTemplateColumn HeaderText="JC SUBCON" SortExpression="SUB_CON_NAME">
                                <EditItemTemplate>
                                    <telerik:RadDropDownList ID="ddlSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" SelectedValue='<%# Bind("SC_ID") %>'
                                        Width="127px">
                                        <Items>
                                            <telerik:DropDownListItem Selected="true" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("SUB_CON_NAME") %>' Width="127px"></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="MAT_SUB_CON" HeaderText="MAT SUBCON" SortExpression="MAT_SUB_CON" ReadOnly="true" />            
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke;">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 100%; text-align: left;">
                            <telerik:RadDropDownList ID="ddReports" runat="server" Width="400px" ExpandDirection="Up">
                                <Items>
                                    <%--<telerik:DropDownListItem Selected="True" Value="6" Text="Jobcard Transmittal"></telerik:DropDownListItem>--%>
                                    <telerik:DropDownListItem Value="3" Text="Request for Field Installation - Isometric"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="2" Text="Material Pick Ticket - JC Wise"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="12" Text="Material Pick Ticket - Isometric Wise"></telerik:DropDownListItem>
                                    <%--<telerik:DropDownListItem Value="10" Text="Fabrication Spool List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="11" Text="Erection Support List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="7" Text="Welding Report for Piping"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="1" Text="Spool Cleaning Rec"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="4" Text="Punch List"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="5" Text="Remaining Work List (Blank)"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="15" Text="Remaining Work List (With Data)"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="13" Text="Field Material List for Field Installation"></telerik:DropDownListItem>
                                    <telerik:DropDownListItem Value="14" Text="Material Shortage Report"></telerik:DropDownListItem>--%>
                                </Items>
                            </telerik:RadDropDownList>
                            <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="78px" EnableViewState="False" OnClick="btnPreview_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="LooseIssueDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsErectionTableAdapters.VIEW_SITE_JCTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="ISSUE_BY" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="PCWBS" Type="String" />
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="JC_REV" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_JC_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="ISSUE_NO" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
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
    <asp:SqlDataSource ID="MaterialDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT DISTINCT MAT_GROUP FROM PIP_MAT_TYPE WHERE (PROJ_ID = :PROJECT_ID) ORDER BY MAT_GROUP'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MatSubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID , SUB_CON_NAME  FROM SUB_CONTRACTOR 
WHERE (PROJ_ID = :PROJECT_ID)
AND (SUB_CON_ID = :SUB_CON_ID OR COMMON_STORE='Y')  ORDER BY SUB_CON_NAME">
  <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
