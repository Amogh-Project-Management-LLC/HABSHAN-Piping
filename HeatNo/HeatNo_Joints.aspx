<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="HeatNo_Joints.aspx.cs" Inherits="HeatNo_HeatNo_Joints" Title="Heat No - Joints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="130px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="jointsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
            DataSourceID="JointsDataSource" Width="100%" AllowPaging="True" OnDataBound="jointsGridView_DataBound"
            PageSize="12">
            <MasterTableView>
                <Columns>                    
                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isome" SortExpression="ISO_TITLE1" />
                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool No" SortExpression="SPOOL" />
                    <telerik:GridBoundColumn DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" />
                    <telerik:GridBoundColumn DataField="JNT_REV_CODE" HeaderText="Rev-Code" SortExpression="JNT_REV_CODE" />
                    <telerik:GridBoundColumn DataField="CAT_NAME" HeaderText="SF" SortExpression="CAT_NAME" />
                    <telerik:GridBoundColumn DataField="JOINT_TYPE" HeaderText="Type" SortExpression="JOINT_TYPE" />
                    <telerik:GridBoundColumn DataField="JOINT_SIZE" HeaderText="Size" SortExpression="JOINT_SIZE" />
                    <telerik:GridBoundColumn DataField="HEAT_NO1" HeaderText="Heat No1" SortExpression="HEAT_NO1" />
                    <telerik:GridBoundColumn DataField="HEAT_NO2" HeaderText="Heat No2" SortExpression="HEAT_NO2" />
                    <telerik:GridBoundColumn DataField="WPS_NO" HeaderText="WPS Number" SortExpression="WPS_NO" />
                    <telerik:GridBoundColumn DataField="FITUP_REP_NO" HeaderText="Fitup Rep No" SortExpression="FITUP_REP_NO" />
                    <telerik:GridBoundColumn DataField="WELD_REP_NO" HeaderText="Weld Rep No" SortExpression="WELD_REP_NO" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="JointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_TOTAL_JOINTS WHERE PROJ_ID = :PROJECT_ID AND (HEAT_NO1 = :HAET_NO OR HEAT_NO2 = :HEAT_NO) ORDER BY ISO_TITLE1, JOINT_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:QueryStringParameter DefaultValue="~" Name="HAET_NO" QueryStringField="HEAT_NO" />
            <asp:QueryStringParameter DefaultValue="~" Name="HEAT_NO" QueryStringField="HEAT_NO" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
