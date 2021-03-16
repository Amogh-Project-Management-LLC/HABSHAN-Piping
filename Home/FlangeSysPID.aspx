<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="FlangeSysPID.aspx.cs" Inherits="Home_FlangeSys_PID_Data" Title="PID Data" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
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

                <td style="width: 87px">
                    <telerik:RadButton ID="btnEntry" runat="server" Text="Entry" Width="80px" OnClick="btnEntry_Click" CausesValidation="False" />
                </td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click" Visible="false" ValidationGroup="Submit" />
                </td>

            </tr>
        </table>
    </div>

    <table style="width: 100%" runat="server" id="EntryTable" visible="false">

        <tr>
            <td style="width: 160px; background-color: #ccccff">PID Number
            </td>
            <td>
                <telerik:RadComboBox ID="RadcobPidNo" runat="server" DataSourceID="PidDataSource" DataTextField="PID_NUMBER"
                    AllowCustomText="true" Filter="Contains" DataValueField="PID_SEQ" Width="200px" DropDownWidth="250px" Height="200px"
                    AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select PID Number"
                    ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnSelectedIndexChanged="RadcobPidNo_SelectedIndexChanged">
                </telerik:RadComboBox>

                <%--<telerik:RadTextBox ID="txtPID_NUMBER" runat="server" Width="160px"></telerik:RadTextBox>
                <asp:RequiredFieldValidator ID="PIDValidator" runat="server" ControlToValidate="txtPID_NUMBER" onkeypress="handleSpace(event)"
                    ErrorMessage="*" ValidationGroup="Submit" ForeColor="Red"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">PID Area
            </td>
            <td>
                <telerik:RadTextBox ID="txtArea" RenderMode="Lightweight" Width="200px" runat="server" Enabled="false">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">PID Descr
            </td>
            <td>
                <telerik:RadTextBox ID="txtPID_DESCR" RenderMode="Lightweight" TextMode="MultiLine" Resize="Both" Width="200px"
                    runat="server" Enabled="false">
                </telerik:RadTextBox>

            </td>
        </tr>




    </table>


    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="FlangeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="UNIQ_ID" DataSourceID="FlangeDataSource" PageSize="50" AllowSorting="true" OnItemCommand="FlangeGridView_ItemCommand"
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
                   
                    <MasterTableView DataSourceID="FlangeDataSource" DataKeyNames="UNIQ_ID" AutoGenerateColumns="False" PageSize="50"
                        AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" AllowFilteringByColumn="true" EditMode="InPlace"
                        AllowMultiColumnSorting="true" ClientDataKeyNames="UNIQ_ID" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>

                           
                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn">
                                <ItemStyle Width="35px" />
                                <HeaderStyle Width="35px" />
                            </telerik:GridButtonColumn>
                             <telerik:GridBoundColumn DataField="AREA" HeaderText="AREA" SortExpression="AREA" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PID_NUMBER" HeaderText="PID NUMBER" SortExpression="PID_NUMBER" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PID_DESCR" HeaderText="PID DESCR" SortExpression="SYSTEM_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="100px" HeaderStyle-HorizontalAlign="Left">
                                <ItemStyle Width="400px" />
                                <HeaderStyle Width="400px" />
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
        SelectCommand="SELECT UNIQ_ID,SYSTEM_NO, SUB_SYSTEM_NO,FLANGE_PID_DATA.AREA,FLANGE_PID_DATA.PID_NUMBER,FLANGE_PID_DATA.PID_DESCR FROM FLANGE_SYSPID_DATA 
                       INNER JOIN FLANGE_SYS_DATA ON FLANGE_SYSPID_DATA.SEQ = FLANGE_SYS_DATA.SEQ
                       INNER JOIN FLANGE_PID_DATA ON FLANGE_SYSPID_DATA.PID_SEQ = FLANGE_PID_DATA.PID_SEQ 
                       WHERE FLANGE_SYSPID_DATA.SEQ =:SEQ 
                       ORDER BY SYSTEM_NO,SUB_SYSTEM_NO,FLANGE_PID_DATA.PID_NUMBER"
        DeleteCommand="DELETE FROM FLANGE_SYSPID_DATA WHERE UNIQ_ID = :UNIQ_ID"
        UpdateCommand="UPDATE FLANGE_SYSPID_DATA SET PID_DESCR = :PID_DESCR WHERE UNIQ_ID =:UNIQ_ID"
        InsertCommand="INSERT INTO FLANGE_SYSPID_DATA (SEQ, PID_SEQ ) VALUES (:SEQ,:PID_SEQ)">
        <SelectParameters>
            <asp:QueryStringParameter Name="SEQ" DefaultValue="" QueryStringField="SEQ" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="UNIQ_ID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>

            <asp:Parameter Name="PID_DESCR" Type="String" />
            <asp:Parameter Name="UNIQ_ID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="SEQ" DefaultValue="" QueryStringField="SEQ" Type="Decimal" />
            <asp:ControlParameter Name="PID_SEQ" DefaultValue="" ControlID="RadcobPidNo" PropertyName="SelectedValue" Type="String" />
            
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="PidDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT PID_SEQ, PID_NUMBER FROM FLANGE_PID_DATA ORDER BY PID_NUMBER"></asp:SqlDataSource>
</asp:Content>
