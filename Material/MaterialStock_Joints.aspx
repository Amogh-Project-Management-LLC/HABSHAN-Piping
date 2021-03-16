<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStock_Joints.aspx.cs" Inherits="MaterialStock_Joints" Title="Material - Joints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
            OnClick="btnBack_Click">
        </telerik:RadButton>
          <telerik:RadButton ID="btnDWN" runat="server" Text="Download" Width="80px"
            OnClick="btnDWN_Click">
        </telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="jointsGridView" runat="server" AutoGenerateColumns="False" 
            DataSourceID="JointsDataSource" Width="100%" AllowPaging="True" PageSize="10" >
            <MasterTableView AutoGenerateColumns="False" DataSourceID="JointsDataSource">
                <Columns>
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isome" SortExpression="ISO_TITLE1" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool No" SortExpression="SPOOL" />
                    <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" />
                    <telerik:GridBoundColumn DataField="JNT_REV_CODE" HeaderText="Rev-Code" SortExpression="JNT_REV_CODE" />
                    <telerik:GridBoundColumn DataField="CAT_NAME" HeaderText="SF" SortExpression="CAT_NAME" />
                    <telerik:GridBoundColumn DataField="JOINT_TYPE" HeaderText="Type" SortExpression="JOINT_TYPE" />
                    <telerik:GridBoundColumn DataField="JOINT_SIZE_DEC" HeaderText="Size" SortExpression="JOINT_SIZE_DEC" />
                    <telerik:GridBoundColumn DataField="ITEM_CODE1" HeaderText="Item 1" SortExpression="ITEM_CODE1" />
                    <telerik:GridBoundColumn DataField="ITEM_CODE2" HeaderText="Item 2" SortExpression="ITEM_CODE2" />
                    <telerik:GridBoundColumn DataField="FITUP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Fitup Date"
                        HtmlEncode="False" SortExpression="FITUP_DATE" />
                    <telerik:GridBoundColumn DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Weld Date" />
                    <telerik:GridBoundColumn DataField="WELD_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Weld Date"
                        HtmlEncode="False" SortExpression="WELD_DATE" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="JointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOB_CODE, ISO_TITLE1, WO_NAME,
SHEET, SPOOL,
MAT_TYPE, MAT_CLASS, JOINT_NO, CAT_NAME, JNT_REV_CODE, JOINT_TYPE, JOINT_SIZE_DEC, JOINT_THK, SCHEDULE, HEAT_NO1, HEAT_NO2,
FITUP_DATE, WELD_DATE, FITUP_REP_NO, WELD_REP_NO, WPS_NO, TW_FLG, NDE_SW, PROG_SW, ITEM_CODE1, ITEM_CODE2
FROM VIEW_TOTAL_JOINTS
WHERE (PROJ_ID = :PROJECT_ID)
AND ((MAT_ID1 = :MAT_ID) OR (MAT_ID2 = :MAT_ID))
ORDER BY   ISO_TITLE1, JOINT_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
