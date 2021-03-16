<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="FlangePIDsys.aspx.cs" Inherits="Home_FlangePID_sys_Data" Title="PID Data" %>

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
            <td style="width: 160px; background-color: #ccccff">System & SubSys Number
            </td>
            <td>
                <telerik:RadComboBox ID="RadcobSysSub" runat="server" DataSourceID="SysSubDataSource" DataTextField="SYS_SUB"
                    AllowCustomText="true" Filter="Contains" DataValueField="SEQ" Width="200px" DropDownWidth="250px" Height="200px"
                    AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select SYS & SUB Number"
                    ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true" OnSelectedIndexChanged="RadcobSysSub_SelectedIndexChanged">
                </telerik:RadComboBox>

            </td>
        </tr>
        
        <tr>
            <td style="width: 160px; background-color: #ccccff">Area
            </td>
            <td>
                <telerik:RadTextBox ID="txtArea" RenderMode="Lightweight" Width="200px" runat="server" Enabled="false">
                </telerik:RadTextBox>

            </td>
        </tr>
        <tr>
            <td style="width: 160px; background-color: #ccccff">System Descr
            </td>
            <td>
                <telerik:RadTextBox ID="txtSYSTEM_DESCR" RenderMode="Lightweight" TextMode="MultiLine" Resize="Both" Width="200px"
                    runat="server" Enabled="false">
                </telerik:RadTextBox>

            </td>
        </tr>
    </table>

    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadGrid ID="FlangeGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="UNIQ_ID" DataSourceID="FlangeDataSource" PageSize="50" AllowSorting="true"  OnItemCommand="FlangeGridView_ItemCommand"
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
                            <telerik:GridBoundColumn DataField="AREA" HeaderText="AREA" SortExpression="AREA" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>

                          <telerik:GridBoundColumn DataField="SYSTEM_NO" HeaderText="SYSTEM NUM" SortExpression="SYSTEM_NO" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="SUB_SYSTEM_NO" HeaderText="SUB SYSTEM NUM" SortExpression="SUB_SYSTEM_NO" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
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
                            <telerik:GridBoundColumn DataField="JOINT_CNT" HeaderText="JOINT COUNT" SortExpression="JOINT_CNT" AutoPostBackOnFilter="true" FilterControlWidth="60px">
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
        SelectCommand="SELECT UNIQ_ID,FLANGE_SYS_DATA.AREA,FLANGE_SYS_DATA.SYSTEM_NO, SUB_SYSTEM_NO,SYSTEM_DESCR,FLANGE_SYS_DATA.REV_NO,
                        FLANGE_PID_DATA.PID_NUMBER,FLANGE_PID_DATA.PID_DESCR,JOINT_CNT 
                        FROM FLANGE_SYSPID_DATA 
                         INNER JOIN FLANGE_SYS_DATA ON FLANGE_SYSPID_DATA.SEQ = FLANGE_SYS_DATA.SEQ
                         INNER JOIN FLANGE_PID_DATA ON   FLANGE_SYSPID_DATA.PID_SEQ = FLANGE_PID_DATA.PID_SEQ
                         LEFT OUTER JOIN
                          (SELECT SYSTEM_NO,COUNT(JOINT_NO) AS JOINT_CNT
                            FROM   PIP_SITE_JOINTS GROUP BY SYSTEM_NO) PROGRESS_DATA
                          ON FLANGE_SYS_DATA.SYSTEM_NO||'_'||SUB_SYSTEM_NO = PROGRESS_DATA.SYSTEM_NO
                        WHERE FLANGE_PID_DATA.PID_SEQ =:PID_SEQ 
                        ORDER BY SYSTEM_NO,SUB_SYSTEM_NO"
        DeleteCommand="DELETE FROM FLANGE_SYSPID_DATA WHERE UNIQ_ID = :UNIQ_ID"
        InsertCommand="INSERT INTO FLANGE_SYSPID_DATA (SEQ, PID_SEQ ) VALUES (:SEQ,:PID_SEQ)">
        <SelectParameters>
            <asp:QueryStringParameter Name="PID_SEQ" DefaultValue="" QueryStringField="PID_SEQ" Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="UNIQ_ID" Type="String" />
        </DeleteParameters>
       
        <InsertParameters>
            <asp:QueryStringParameter Name="PID_SEQ" DefaultValue="" QueryStringField="PID_SEQ" Type="Decimal" />
            <asp:ControlParameter Name="SEQ" DefaultValue="" ControlID="RadcobSysSub" PropertyName="SelectedValue" Type="String" />
            
        </InsertParameters>
    </asp:SqlDataSource>
  <asp:SqlDataSource ID="SysSubDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT SEQ, SYSTEM_NO||'_'||SUB_SYSTEM_NO AS SYS_SUB   FROM FLANGE_SYS_DATA ORDER BY SYSTEM_NO,SUB_SYSTEM_NO"></asp:SqlDataSource>
       <asp:SqlDataSource ID="PidDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT PID_SEQ, PID_NUMBER FROM FLANGE_PID_DATA ORDER BY PID_NUMBER"></asp:SqlDataSource>
</asp:Content>
