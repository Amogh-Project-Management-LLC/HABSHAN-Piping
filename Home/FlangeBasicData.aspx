<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="FlangeBasicData.aspx.cs" Inherits="Home_Flange_Basic_Data" Title="Flange Data" %>

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

    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
     <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="FlangeGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table style="width: 100%;">
            <tr>

                <td style="width: 85px ; display:none">
                    <div id="HeaderDiv" style="width: 83px">
                        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click" />
                    </div>
                </td>

                <td style="width: 87px">
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False"/>
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" ValidationGroup="Submit"/>
                </td>

            </tr>
        </table>
    </div>

    <table style="width: 100%" runat="server" id="EntryTable" visible="false">

        <tr>
            <td style="width: 160px; background-color: #ccccff">Mat Code
            </td>
            <td>
                <telerik:RadTextBox ID="txtMAT_CODE1" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="MatcodeValidator" runat="server" ControlToValidate="txtMAT_CODE1"
                    ErrorMessage="*"  ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Flange Size
            </td>
            <td>
                <telerik:RadTextBox ID="txtFLANGE_SIZE" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Flange Rating
            </td>
            <td>
                <telerik:RadTextBox ID="txtFLANGE_RATING" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Pipe Class
            </td>
            <td>
                <telerik:RadTextBox ID="txtPIPE_CLASS" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Flange Material
            </td>
            <td>
                <telerik:RadTextBox ID="txtFLANGE_MATERIAL" runat="server" Width="160px"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff" >Bolt Material
            </td>
            <td>
                <telerik:RadTextBox ID="txtBOLT_MATERIAL" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Bolt Size
            </td>
            <td>
                <telerik:RadTextBox ID="txtBOLT_SIZE" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">No Of Bolts
            </td>
            <td>
                <telerik:RadTextBox ID="txtNO_OF_BOLTS" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Type Of Thread
            </td>
            <td>
                <telerik:RadTextBox ID="txtTHREAD_TYPE" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Bolt Stress (MPA)
            </td>
            <td>
                <telerik:RadTextBox ID="txtBOLT_STRESS_MPA" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Bolt Stress (PSI)
            </td>
            <td>
                <telerik:RadTextBox ID="txtBOLT_STRESS_PSI" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Torque Value (N-M)
            </td>
            <td>
                <telerik:RadTextBox ID="txtTORQUE_VALUE_N_M" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Torque Value (LB-FT)
            </td>
            <td>
                <telerik:RadTextBox ID="txtTORQUE_VALUE_LB_FT" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">Gasket Type
            </td>
            <td>
                <telerik:RadTextBox ID="txtGASKET_TYPE" runat="server" Width="160px" onkeypress="handleSpace(event)"></telerik:RadTextBox>
            </td>
        </tr>

    </table>

    <div>
        <telerik:RadGrid ID="FlangeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="MAT_CODE1" DataSourceID="FlangeDataSource"
            PageSize="50" AllowSorting="true" OnItemCommand="FlangeGridView_ItemCommand" OnPreRender="FlangeGridView_PreRender"
            PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)">
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
            <MasterTableView DataSourceID="FlangeDataSource" DataKeyNames="MAT_CODE1" AutoGenerateColumns="False" PageSize="50"
                AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" EditMode="InPlace"
                AllowMultiColumnSorting="true" ClientDataKeyNames="MAT_CODE1" TableLayout="Fixed">
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
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MAT CODE" SortExpression="MAT_CODE1" ReadOnly="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FLANGE_SIZE" HeaderText="FLANGE SIZE" SortExpression="FLANGE_SIZE" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FLANGE_RATING" HeaderText="FLANGE RATING" SortExpression="FLANGE_RATING" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIPE_CLASS" HeaderText="PIPE CLASS" SortExpression="PIPE_CLASS" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FLANGE_MATERIAL" HeaderText="FLANGE MATERIAL" SortExpression="FLANGE_MATERIAL" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOLT_MATERIAL" HeaderText="BOLT MATERIAL" SortExpression="BOLT_MATERIAL" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOLT_SIZE" HeaderText="BOLT SIZE" SortExpression="BOLT_SIZE" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NO_OF_BOLTS" HeaderText="NO OF BOLTS" SortExpression="NO_OF_BOLTS" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="THREAD_TYPE" HeaderText="TYPE OF THREAD" SortExpression="THREAD_TYPE" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOLT_STRESS_MPA" HeaderText="BOLT STRESS (MPA)" SortExpression="UOM_NAME" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOLT_STRESS_PSI" HeaderText="BOLT STRESS (PSI)" SortExpression="BOLT_STRESS_PSI" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TORQUE_VALUE_N_M" HeaderText="TORQUE VALUE (N-M)" SortExpression="TORQUE_VALUE_N_M" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TORQUE_VALUE_LB_FT" HeaderText="TORQUE VALUE (LB-FT)" SortExpression="TORQUE_VALUE_LB_FT" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="GASKET_TYPE" HeaderText="GASKET_TYPE" SortExpression="GASKET_TYPE" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="FlangeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM PIP_SITE_JOINTS_IPMS ORDER BY MAT_CODE1"
        DeleteCommand="DELETE FROM PIP_SITE_JOINTS_IPMS WHERE MAT_CODE1 = :MAT_CODE1"
        UpdateCommand="UPDATE PIP_SITE_JOINTS_IPMS SET  FLANGE_SIZE = :FLANGE_SIZE, FLANGE_RATING = :FLANGE_RATING, PIPE_CLASS = :PIPE_CLASS, FLANGE_MATERIAL = :FLANGE_MATERIAL,
                                                        BOLT_MATERIAL = :BOLT_MATERIAL, BOLT_SIZE = :BOLT_SIZE , NO_OF_BOLTS = :NO_OF_BOLTS, THREAD_TYPE = :THREAD_TYPE,
                                                        BOLT_STRESS_MPA = :BOLT_STRESS_MPA, BOLT_STRESS_PSI = :BOLT_STRESS_PSI, TORQUE_VALUE_N_M = :TORQUE_VALUE_N_M,
                                                        TORQUE_VALUE_LB_FT = :TORQUE_VALUE_LB_FT, GASKET_TYPE = :GASKET_TYPE
                        WHERE MAT_CODE1 = :MAT_CODE1"
        InsertCommand="INSERT INTO PIP_SITE_JOINTS_IPMS (MAT_CODE1, FLANGE_SIZE, FLANGE_RATING, PIPE_CLASS, FLANGE_MATERIAL,
                                                          BOLT_MATERIAL, BOLT_SIZE, NO_OF_BOLTS, THREAD_TYPE,
                                                          BOLT_STRESS_MPA, BOLT_STRESS_PSI, TORQUE_VALUE_N_M,
                                                         TORQUE_VALUE_LB_FT, GASKET_TYPE) 
                                                   VALUES
                                                       ( :MAT_CODE1 ,:FLANGE_SIZE, :FLANGE_RATING, :PIPE_CLASS, :FLANGE_MATERIAL,
                                                          :BOLT_MATERIAL, :BOLT_SIZE, :NO_OF_BOLTS, :THREAD_TYPE,
                                                          :BOLT_STRESS_MPA, :BOLT_STRESS_PSI, :TORQUE_VALUE_N_M,
                                                          :TORQUE_VALUE_LB_FT, :GASKET_TYPE) ">

        <DeleteParameters>
            <asp:Parameter Name="MAT_CODE1" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FLANGE_SIZE" Type="String" />
            <asp:Parameter Name="FLANGE_RATING" Type="String" />
            <asp:Parameter Name="PIPE_CLASS" Type="String" />
            <asp:Parameter Name="FLANGE_MATERIAL" Type="String" />
            <asp:Parameter Name="BOLT_MATERIAL" Type="String" />
            <asp:Parameter Name="BOLT_SIZE" Type="String" />
            <asp:Parameter Name="NO_OF_BOLTS" Type="String" />
            <asp:Parameter Name="THREAD_TYPE" Type="String" />
            <asp:Parameter Name="BOLT_STRESS_MPA" Type="String" />
            <asp:Parameter Name="BOLT_STRESS_PSI" Type="String" />
            <asp:Parameter Name="TORQUE_VALUE_N_M" Type="String" />
            <asp:Parameter Name="TORQUE_VALUE_LB_FT" Type="String" />
            <asp:Parameter Name="GASKET_TYPE" Type="String" />
            <asp:Parameter Name="MAT_CODE1" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:ControlParameter Name="MAT_CODE1" ControlID="txtMAT_CODE1" Type="String" />
            <asp:ControlParameter Name="FLANGE_SIZE" ControlID="txtFLANGE_SIZE" Type="String" />
            <asp:ControlParameter Name="FLANGE_RATING" ControlID="txtFLANGE_RATING" Type="String" />
            <asp:ControlParameter Name="PIPE_CLASS" ControlID="txtPIPE_CLASS" Type="String" />
            <asp:ControlParameter Name="FLANGE_MATERIAL" ControlID="txtFLANGE_MATERIAL" Type="String" />
            <asp:ControlParameter Name="BOLT_MATERIAL" ControlID="txtBOLT_MATERIAL" Type="String" />
            <asp:ControlParameter Name="BOLT_SIZE" ControlID="txtBOLT_SIZE" Type="String" />
            <asp:ControlParameter Name="NO_OF_BOLTS" ControlID="txtNO_OF_BOLTS" Type="String" />
            <asp:ControlParameter Name="THREAD_TYPE" ControlID="txtTHREAD_TYPE" Type="String" />
            <asp:ControlParameter Name="BOLT_STRESS_MPA" ControlID="txtBOLT_STRESS_MPA" Type="String" />
            <asp:ControlParameter Name="BOLT_STRESS_PSI" ControlID="txtBOLT_STRESS_PSI" Type="String" />
            <asp:ControlParameter Name="TORQUE_VALUE_N_M" ControlID="txtTORQUE_VALUE_N_M" Type="String" />
            <asp:ControlParameter Name="TORQUE_VALUE_LB_FT" ControlID="txtTORQUE_VALUE_LB_FT" Type="String" />
            <asp:ControlParameter Name="GASKET_TYPE" ControlID="txtGASKET_TYPE" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

</asp:Content>
