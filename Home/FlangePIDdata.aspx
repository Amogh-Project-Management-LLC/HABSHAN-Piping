<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FlangePIDdata.aspx.cs" Inherits="Home_FlangePIDmain_Data" Title="PID Data" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }


        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= FlangeGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }


        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }

        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= FlangeGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("grad").clientWidth - document.getElementById("navigation_left").clientWidth;
            grid.get_element().style.height = (height) - 200 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.get_element()
            grid.repaint();
        }

        function view_sys() {
            try {
                var pid = $find("<%=FlangeGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("PID_SEQ");

                radopen("../Home/FlangePIDsys.aspx?PID_SEQ=" + pid, "RadWindow1", 800, 550);
            }
            catch (err) {
                txt = "Select any Record!";
                alert(txt);
            }
        }
        function bulkPid() {
            try {

                window.location = "../Isome/BulkReportImport.aspx?IMPORT_ID=47";
            }
            catch (err) {
                alert(err);
            }
        }
         function bulkSysPid() {
            try {

                window.location = "../Isome/BulkReportImport.aspx?IMPORT_ID=43";
            }
            catch (err) {
                alert(err);
            }
        }
        

    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="FlangeGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table>
            <tr>
                <td style="width: 85px; display: none">
                    <div id="HeaderDiv" style="width: 83px">
                        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click" />
                    </div>
                </td>

                <td style="width: 87px;">
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" Visible="false" ValidationGroup="Submit" />
                </td>
                <td>
                    <telerik:RadButton ID="btnSysnum" runat="server" AutoPostBack="false" Width="90px">
                        <ContentTemplate>
                            <asp:LinkButton ID="linkSysnum" runat="server" OnClientClick="view_sys(); return false;" Font-Underline="false"
                                Text="Sys Data" ForeColor="#003366"></asp:LinkButton>
                        </ContentTemplate>
                    </telerik:RadButton>

                </td>
                <td>
                    <asp:LinkButton ID="linkPIDdata" runat="server" OnClientClick="bulkPid(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton ID="btnBulkPIDdata" runat="server" Text="Bulk PID Import" Width="140px"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton ID="linkSysPIDdata" runat="server" OnClientClick="bulkSysPid(); return false;" Font-Underline="false"
                        ForeColor="#003366">
                        <telerik:RadButton ID="btnBulkSysPIDdata" runat="server" Text="Bulk Sys & PID Import" Width="160px"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
            </tr>
        </table>
    </div>

    <table style="width: 100%" runat="server" id="EntryTable" visible="false">

        <tr>
            <td style="width: 160px; background-color: #ccccff">PID Number
            </td>
            <td>
                <telerik:RadTextBox ID="txtPID_NUMBER" runat="server" Width="160px"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="PIDValidator" runat="server" ControlToValidate="txtPID_NUMBER" onkeypress="handleSpace(event)"
                    ErrorMessage="*" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td style="width: 160px; background-color: #ccccff">PID Descr
            </td>
            <td>
                <telerik:RadTextBox RenderMode="Lightweight" TextMode="MultiLine" Resize="Both" Width="200px" ID="txtPID_DESCR"
                    runat="server" onkeypress="handleSpace(event)">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Area
            </td>
            <td>
                <telerik:RadComboBox ID="RadcobArea" runat="server" DataSourceID="AreaDataSource" DataTextField="AREA"
                    AllowCustomText="true" Filter="Contains" DataValueField="AREA" Width="200px" DropDownWidth="250px" Height="200px"
                    AutoPostBack="true" CausesValidation="false" EmptyMessage="Select Area">
                </telerik:RadComboBox>


            </td>
        </tr>


    </table>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="FlangeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="PID_SEQ" DataSourceID="FlangeDataSource" PageSize="50" AllowSorting="true" OnItemCommand="FlangeGridView_ItemCommand"
                    PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)" OnItemDataBound="FlangeGridView_ItemDataBound"
                    OnPreRender="FlangeGridView_PreRender" ShowFooter="true"   EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                    <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>

                    <HeaderStyle HorizontalAlign="Center" />
                    <ClientSettings>
                        <Selecting AllowRowSelect="True" />
                        <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                    </ClientSettings>
                    <ClientSettings AllowKeyboardNavigation="true">
                        <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                            AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                    </ClientSettings>
                    <ClientSettings>
                        <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                    </ClientSettings>

                    <MasterTableView DataSourceID="FlangeDataSource" DataKeyNames="PID_SEQ" AutoGenerateColumns="False" PageSize="50"
                        AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" EditMode="InPlace"
                        AllowMultiColumnSorting="true" ClientDataKeyNames="PID_SEQ" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>
                            <telerik:GridTemplateColumn  AllowFiltering="false" HeaderText="COMM. MARKUP">
                                <ItemTemplate>
                                    <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn DataField="MPpdfDt" UniqueName="MPpdfDt" SortExpression="MPpdfDt" AllowFiltering="false" HeaderText="MARKUP PID FJ." >
                                <ItemTemplate>
                                    <asp:Label ID="MPpdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="AREA" FilterControlAltText="Filter AREA column" HeaderText="AREA"
                                SortExpression="AREA" UniqueName="AREA" AllowFiltering="true" AutoPostBackOnFilter="true" GroupByExpression="AREA Group By AREA">
                                <ItemStyle Width="250px" />
                                <HeaderStyle Width="250px" />
                                <EditItemTemplate>
                                    <telerik:RadComboBox ID="gridrcbAREA" runat="server" DataSourceID="AreaDataSource" AllowCustomText="true"
                                        Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                        ItemsPerRequest="10" ShowMoreResultsBox="true"
                                        DataTextField="AREA" DataValueField="AREA" SelectedValue='<%# Bind("AREA") %>'
                                        AppendDataBoundItems="True">
                                        <Items>
                                            <telerik:RadComboBoxItem Selected="true" />
                                        </Items>
                                    </telerik:RadComboBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="AREALabel" runat="server" Text='<%# Eval("AREA") %>'></asp:Label>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridBoundColumn DataField="PID_NUMBER" HeaderText="PID NUMBER" SortExpression="PID_NUMBER" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PID_DESCR" HeaderText="PID DESCR" SortExpression="SYSTEM_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="100px" HeaderStyle-HorizontalAlign="Left">
                                <ItemStyle Width="400px" />
                                <HeaderStyle Width="400px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISO_CNT" HeaderText="NO OF ISO'S" SortExpression="ISO_CNT" AutoPostBackOnFilter="true" FilterControlWidth="60px" ReadOnly="true">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ISO_JOINT" HeaderText="ISO JOINTS" SortExpression="ISO_JOINT" AutoPostBackOnFilter="true" FilterControlWidth="60px" ReadOnly="true">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PID_JOINT" HeaderText="PID JOINTS" SortExpression="PID_JOINT" AutoPostBackOnFilter="true" FilterControlWidth="60px"
                                FooterText="Done : " Aggregate="Sum" ReadOnly="true">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="FINAL_STATUS" HeaderText="PROGRESS STATUS" SortExpression="FINAL_STATUS" AutoPostBackOnFilter="true" FilterControlWidth="80px" ReadOnly="true">
                                <ItemStyle Width="120px" />
                                <HeaderStyle Width="120px" />
                            </telerik:GridBoundColumn>



                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>



    <asp:SqlDataSource ID="FlangeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM VIEW_PID_PROGRESS"
        DeleteCommand="DELETE FROM FLANGE_PID_DATA WHERE PID_SEQ = :PID_SEQ"
        UpdateCommand="UPDATE FLANGE_PID_DATA SET PID_NUMBER=:PID_NUMBER,PID_DESCR =:PID_DESCR, AREA =:AREA WHERE PID_SEQ =:PID_SEQ "
        InsertCommand="INSERT INTO FLANGE_PID_DATA ( PID_NUMBER ,PID_DESCR, AREA) VALUES (:PID_NUMBER,:PID_DESCR,:AREA)">

        <DeleteParameters>
            <asp:Parameter Name="PID_SEQ" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="PID_NUMBER" Type="String" />
            <asp:Parameter Name="PID_DESCR" Type="String" />
            <asp:Parameter Name="AREA" Type="String" />
            <asp:Parameter Name="PID_SEQ" Type="Decimal" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter Name="PID_NUMBER" DefaultValue="" ControlID="txtPID_NUMBER" Type="String" />
            <asp:ControlParameter Name="PID_DESCR" ControlID="txtPID_DESCR" Type="String" />
            <asp:ControlParameter Name="AREA" ControlID="RadcobArea" PropertyName="SelectedValue" DefaultValue="" Type="String" />

        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT  AREA_L2 AS AREA FROM IPMS_AREA ORDER BY  AREA_L2"></asp:SqlDataSource>
</asp:Content>
