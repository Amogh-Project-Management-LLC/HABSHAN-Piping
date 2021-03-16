<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV.aspx.cs" Inherits="Material_Reports_JC_MIV" Title="Jobcard MIV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= mivGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=mivGridView.ClientID %>").get_masterTableView();
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element()
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke;">

        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="New" Width="80"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSpools" runat="server" Text="Spools" Width="80" OnClick="btnSpools_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMaterials" runat="server" Text="Materials" Width="80" OnClick="btnMaterials_Click"></telerik:RadButton>
                </td>

                <%-- <td>
                            <telerik:RadButton ID="btnPreview1" runat="server" Text="MIV Required" Width="120" OnClick="btnPreview1_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnMivMats" runat="server" Text="Summary" Width="100" OnClick="btnMivMats_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnMivSpool" runat="server" Text="MIV Spools" Width="100" OnClick="btnMivSpool_Click"></telerik:RadButton>
                        </td>--%>
                <td>
                    <telerik:RadButton ID="btnCutPlan" runat="server" Text="Cutting Plan" Width="100" OnClick="btnCutPlan_Click" Visible="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlReportType" runat="server" Width="150" AutoPostBack="true" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Value="-1" Text="Select Report" />
                            <telerik:DropDownListItem Value="1" Text="MIV Spools" />
                            <telerik:DropDownListItem Value="2" Text="MIV Required" />
                            <telerik:DropDownListItem Value="3" Text="Summary" />
                            <telerik:DropDownListItem Value="4" Text="Pipe Cut List" />
                            <telerik:DropDownListItem Value="5" Text="JCMIV Welding" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnBulkJCMIVSpool" runat="server" Width="150" OnClick="btnBulkJCMIVSpool_Click" Text="JCMIV SPOOL BULK"></telerik:RadButton>
                </td>
                <td>
                      <telerik:RadButton ID="btnCollectPDFs" runat="server" Text="Download PDFs" Width="140px" OnClick="btnCollectPDFs_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" Visible="false"
                        Width="212px" AutoPostBack="True">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>

    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="mivGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"  AllowFilteringByColumn="true"
                    DataSourceID="mivDataSource" PageSize="40" Width="100%" DataKeyNames="ISSUE_ID" PagerStyle-AlwaysVisible="true" OnItemCommand="mivGridView_ItemCommand">
                    <ClientSettings Selecting-AllowRowSelect="true" Scrolling-AllowScroll="true" Scrolling-UseStaticHeaders="true"></ClientSettings>
                    <MasterTableView DataSourceID="mivDataSource" DataKeyNames="ISSUE_ID" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                              <HeaderStyle Width="50px" />
                                <ItemStyle Width="50px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this MIV Transmittal?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <HeaderStyle Width="50px" />
                                <ItemStyle Width="50px" />
                            </telerik:GridButtonColumn>


                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="Issue No" SortExpression="ISSUE_NO" ReadOnly="true" AllowFiltering="true" AutoPostBackOnFilter="true">
                                <HeaderStyle Width="250px" />
                                <ItemStyle Width="250px" />
                                </telerik:GridBoundColumn>
                            
                            <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME" ReadOnly="true" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                  <HeaderStyle Width="150px" />
                                <ItemStyle Width="150px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="STORE_NAME" HeaderText="Store" SortExpression="STORE_NAME" ReadOnly="true" AllowFiltering="false" >
                                  <HeaderStyle Width="100px" />
                                <ItemStyle Width="100px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="WO_NAME" HeaderText="JC Number" SortExpression="WO_NAME" ReadOnly="true" AllowFiltering="true" AutoPostBackOnFilter="true">
                                  <HeaderStyle Width="200px" />
                                <ItemStyle Width="200px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MIVR_NO" HeaderText="MIVR Number" SortExpression="MIVR_NO" ReadOnly="true" AllowFiltering="false">
                                  <HeaderStyle Width="100px" />
                                <ItemStyle Width="100px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISSUE_BY" HeaderText="Issued By" SortExpression="ISSUE_BY" ReadOnly="true" AllowFiltering="false">
                                  <HeaderStyle Width="120px" />
                                <ItemStyle Width="120px" />
                                </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="ISSUE_DATE" DataType="System.DateTime" FilterControlAltText="Filter ISSUE_DATE column" HeaderText="Issue Date" SortExpression="ISSUE_DATE" UniqueName="ISSUE_DATE" >
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtIssueDate" runat="server" SelectedDate='<%# Bind("ISSUE_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy" Width="120px">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="IssueDateLabel" runat="server" Text='<%# Eval("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>' Width="120px"></asp:Label>
                                </ItemTemplate>
                                  <HeaderStyle Width="100px" />
                                <ItemStyle Width="100px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" AllowFiltering="false">
                                  <HeaderStyle Width="100px" />
                                <ItemStyle Width="100px" />
                                </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:ObjectDataSource ID="mivDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsFabricationJCTableAdapters.PIP_MAT_ISSUE_WOTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_ISSUE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_ISSUE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
