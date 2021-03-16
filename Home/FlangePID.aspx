<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FlangePID.aspx.cs" Inherits="Home_Flange_PID_Data" Title="Flange Data" %>

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
                    <telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" Width="140" OnClick="btnBulkImport_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <table style="width: 100%" runat="server" id="EntryTable" visible="false">

        <tr>
            <td style="width: 160px; background-color: #ccccff">PID Number
            </td>
            <td>
                <telerik:RadTextBox ID="txtPID_NUMBER" runat="server" Width="160px"  onkeypress="handleSpace(event)"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="PIDValidator" runat="server" ControlToValidate="txtPID_NUMBER"
                    ErrorMessage="*" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
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
            <td style="width: 160px; background-color: #ccccff">PID Descr
            </td>
            <td>
                <telerik:RadTextBox RenderMode="Lightweight" TextMode="MultiLine" Resize="Both" Width="200px" ID="txtPID_DESCR" runat="server" onkeypress="handleSpace(event)"></telerik:RadTextBox>

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
                <telerik:RadTextBox ID="txtAREA" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
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
                    DataKeyNames="PID_ITEM" DataSourceID="FlangeDataSource"
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
                    <MasterTableView DataSourceID="FlangeDataSource" DataKeyNames="PID_ITEM" AutoGenerateColumns="False" PageSize="50"
                        AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" EditMode="InPlace"
                        AllowMultiColumnSorting="true" ClientDataKeyNames="PID_ITEM" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
                            <telerik:GridBoundColumn DataField="FLANGE_JNT" HeaderText="link connection" SortExpression="FLANGE_JNT" AllowFiltering="false">
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
                            <telerik:GridBoundColumn DataField="AREA" HeaderText="AREA" SortExpression="AREA" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                           
                            <telerik:GridTemplateColumn DataField="SYSTEM_NO" HeaderText="SYSTEM NUM" UniqueName="SYSTEM_NO" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SYSTEM_NOTextBox" runat="server" Text='<%# Bind("SYSTEM_NO") %>' ReadOnly="true"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="SYSTEM_NOLink" runat="server" Text='<%# Eval("SYSTEM_NO") %>' OnClientClick="system_click(this)" ForeColor="BlueViolet" ToolTip="Flange Joints details"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridTemplateColumn>


                            <telerik:GridBoundColumn DataField="SUB_SYSTEM_NO" HeaderText="SUB SYSTEM NUM" SortExpression="SUB_SYSTEM_NO" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SYSTEM_DESCR" HeaderText="SYSTEM DESCR" SortExpression="SYSTEM_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="REV_NO" HeaderText="REV NO" SortExpression="REV_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
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
        SelectCommand="SELECT FLANGE_PID.*,SYSTEM_NO||'_'||SUB_SYSTEM_NO AS FLANGE_JNT FROM FLANGE_PID ORDER BY AREA,PID_NUMBER,SYSTEM_NO,SUB_SYSTEM_NO"
        DeleteCommand="DELETE FROM FLANGE_PID WHERE PID_ITEM = :PID_ITEM"
        UpdateCommand="UPDATE FLANGE_PID SET  AREA = :AREA, PID_DESCR = :PID_DESCR, SYSTEM_DESCR = :SYSTEM_DESCR,  REV_NO = :REV_NO
                        WHERE PID_ITEM = :PID_ITEM"
        InsertCommand="INSERT INTO FLANGE_PID (PID_NUMBER, SYSTEM_NO ,SUB_SYSTEM_NO, AREA,PID_DESCR,SYSTEM_DESCR, REV_NO) 
                                                   VALUES
                                                       ( :PID_NUMBER, :SYSTEM_NO ,:SUB_SYSTEM_NO, :AREA,:PID_DESCR,:SYSTEM_DESCR, :REV_NO) ">

        <DeleteParameters>
            <asp:Parameter Name="PID_ITEM" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="AREA" Type="String" />
            <asp:Parameter Name="PID_DESCR" Type="String" />
            <asp:Parameter Name="SYSTEM_DESCR" Type="String" />
            <asp:Parameter Name="REV_NO" Type="String" />
            <asp:Parameter Name="PID_ITEM" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter Name="PID_NUMBER" ControlID="txtPID_NUMBER" Type="String" />
            <asp:ControlParameter Name="SYSTEM_NO" ControlID="txtSYSTEM_NO" Type="String" />
            <asp:ControlParameter Name="SUB_SYSTEM_NO" ControlID="txtSUB_SYSTEM_NO" Type="String" />
            <asp:ControlParameter Name="AREA" ControlID="txtAREA" Type="String" />
            <asp:ControlParameter Name="PID_DESCR" ControlID="txtPID_DESCR" Type="String" />
            <asp:ControlParameter Name="SYSTEM_DESCR" ControlID="txtSYSTEM_DESCR" Type="String" />
            <asp:ControlParameter Name="REV_NO" ControlID="txtREV_NO" Type="String" />

        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
