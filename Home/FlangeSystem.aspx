<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FlangeSystem.aspx.cs" Inherits="Home_FlangeSystem_Data" Title="Flange System Data" %>

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
        function system_click(lnk) {

            var row = lnk.parentNode.parentNode;
            var grid = $find("<%= FlangeGridView.ClientID %>");
            if (grid) {
                var sys = row.cells[0].innerHTML
                radopen("../Isome/FlangeJntsPopup.aspx?SYSTEM_NO=" + sys, "RadWindow1", 800, 550);
            }
            return false;

        }
        function view_pid() {
            try {
                var seq = $find("<%=FlangeGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("SEQ");

                radopen("../Home/FlangeSysPID.aspx?SEQ=" + seq, "RadWindow1", 800, 550);
            }
            catch (err) {
                txt = "Select any Record!";
                alert(txt);
            }
        }

        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= FlangeGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }

        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
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

                <td style="width: 87px">
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" Visible="false" ValidationGroup="Submit" />
                </td>
               

                <td>
                    <telerik:RadButton ID="btnPIDnum" runat="server" AutoPostBack="false" Width="90px">
                        <ContentTemplate>
                            <asp:LinkButton ID="linkPIDnum" runat="server" OnClientClick="view_pid(); return false;" Font-Underline="false"
                                Text="PID Data" ForeColor="#003366"></asp:LinkButton>
                        </ContentTemplate>
                    </telerik:RadButton>

                </td>
                 <td>
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk System Import" Width="140" OnClick="btnBulkImport_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBulkPID" runat="server" Text="Bulk Sys & PID Import" Width="160" OnClick="btnBulkPID_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <table style="width: 100%" runat="server" id="EntryTable" visible="false">
        <tr>
            <td style="width: 160px; background-color: #ccccff">System Number
            </td>
            <td>
                <telerik:RadTextBox ID="txtSYSTEM_NO" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="SysNoValidator" runat="server" ControlToValidate="txtSYSTEM_NO"
                    ErrorMessage="*" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Sub System Number 
            </td>
            <td>
                <telerik:RadTextBox ID="txtSUB_SYSTEM_NO" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="SubSysNoValidator" runat="server" ControlToValidate="txtSUB_SYSTEM_NO"
                    ErrorMessage="*" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <tr>
            <td style="width: 160px; background-color: #ccccff">System Descr
            </td>
            <td>
                <telerik:RadTextBox RenderMode="Lightweight" TextMode="MultiLine" Resize="Both" Width="200px" ID="txtSYSTEM_DESCR" runat="server" onkeypress="handleSpace(event)"></telerik:RadTextBox>

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

        <tr>
            <td style="width: 160px; background-color: #ccccff">Rev number
            </td>
            <td>
                <telerik:RadTextBox ID="txtREV_NO" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>


    </table>



    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="FlangeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="SEQ" DataSourceID="FlangeDataSource"
                    PageSize="50" AllowSorting="true" OnItemCommand="FlangeGridView_ItemCommand" OnPreRender="FlangeGridView_PreRender"
                    PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)" OnItemDataBound="FlangeGridView_ItemDataBound">

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
                    <MasterTableView DataSourceID="FlangeDataSource" DataKeyNames="SEQ" AutoGenerateColumns="False" PageSize="50"
                        AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" EditMode="InPlace"
                        AllowMultiColumnSorting="true" ClientDataKeyNames="SEQ" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="FLANGE_JNT" HeaderText="link connection" SortExpression="FLANGE_JNT" AllowFiltering="false" ReadOnly="true">
                                <ItemStyle Width="1px" />
                                <HeaderStyle Width="1px" />
                            </telerik:GridBoundColumn>
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
                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="COMM. MARKUP">
                                <ItemTemplate>
                                    <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="MARKUP PID FJ.">
                                <ItemTemplate>
                                    <asp:Label ID="MPpdf" runat="server" Text=""></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridTemplateColumn>
                             <telerik:GridTemplateColumn DataField="AREA" FilterControlAltText="Filter AREA column" HeaderText="AREA"
                                SortExpression="AREA" UniqueName="AREA" AllowFiltering="true" AutoPostBackOnFilter="true">
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

                            <telerik:GridTemplateColumn DataField="FLANGE_JNT" HeaderText="SYSTEM & SUBSYS NUM" UniqueName="UNIQ" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SYSTEM_NOTextBox" runat="server" Text='<%# Bind("FLANGE_JNT") %>' ReadOnly="true"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="SYSTEM_NOLink" runat="server" Text='<%# Eval("FLANGE_JNT") %>' OnClientClick="system_click(this)" ForeColor="BlueViolet" ToolTip="Flange Joints details"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="SYSTEM_NO" HeaderText="SYSTEM NUM" SortExpression="SYSTEM_NO"  AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="SUB_SYSTEM_NO" HeaderText="SUB SYSTEM NUM" SortExpression="SUB_SYSTEM_NO" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SYSTEM_DESCR" HeaderText="SYSTEM DESCR" SortExpression="SYSTEM_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                <ItemStyle Width="300px" />
                                <HeaderStyle Width="300px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="REV_NO" HeaderText="REV NO" SortExpression="REV_NO" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                                 <telerik:GridBoundColumn DataField="PID_CNT" HeaderText="PID COUNT" SortExpression="PID_CNT" AutoPostBackOnFilter="true" FilterControlWidth="60px" ReadOnly="true" >
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
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
        SelectCommand="SELECT FLANGE_SYS_DATA.*,SYSTEM_NO||'_'||SUB_SYSTEM_NO AS FLANGE_JNT,PID_CNT 
                        FROM FLANGE_SYS_DATA 
                        LEFT OUTER JOIN
                        (SELECT SEQ,COUNT(PID_SEQ) AS PID_CNT FROM FLANGE_SYSPID_DATA GROUP BY SEQ) PID_DATA
                        ON FLANGE_SYS_DATA.SEQ = PID_DATA.SEQ
                        ORDER BY AREA,SYSTEM_NO,SUB_SYSTEM_NO"
        DeleteCommand="DELETE FROM FLANGE_SYS_DATA WHERE SEQ = :SEQ"
        UpdateCommand="UPDATE FLANGE_SYS_DATA SET AREA =:AREA ,SYSTEM_NO=:SYSTEM_NO,SUB_SYSTEM_NO=:SUB_SYSTEM_NO,SYSTEM_DESCR =:SYSTEM_DESCR,REV_NO =:REV_NO  WHERE SEQ =:SEQ"
        InsertCommand="INSERT INTO FLANGE_SYS_DATA (SYSTEM_NO ,SUB_SYSTEM_NO, AREA,SYSTEM_DESCR, REV_NO) 
                       VALUES ( :SYSTEM_NO ,:SUB_SYSTEM_NO, :AREA,:SYSTEM_DESCR, :REV_NO) ">

        <DeleteParameters>
            <asp:Parameter Name="SEQ" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="AREA" Type="String" />
            <asp:Parameter Name="SYSTEM_NO" Type="String" />
            <asp:Parameter Name="SUB_SYSTEM_NO" Type="String" />
            <asp:Parameter Name="SYSTEM_DESCR" Type="String" />
            <asp:Parameter Name="REV_NO" Type="String" />
            <asp:Parameter Name="SEQ" Type="Decimal" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter Name="SYSTEM_NO" ControlID="txtSYSTEM_NO" Type="String" />
            <asp:ControlParameter Name="SUB_SYSTEM_NO" ControlID="txtSUB_SYSTEM_NO" Type="String" />
            <asp:ControlParameter Name="AREA" ControlID="RadcobArea" PropertyName="SelectedValue" DefaultValue="" Type="String" />
            <asp:ControlParameter Name="SYSTEM_DESCR" ControlID="txtSYSTEM_DESCR" Type="String" />
            <asp:ControlParameter Name="REV_NO" ControlID="txtREV_NO" Type="String" />

        </InsertParameters>
    </asp:SqlDataSource>
      <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT  AREA_L2 AS AREA FROM IPMS_AREA ORDER BY  AREA_L2"></asp:SqlDataSource>
</asp:Content>
