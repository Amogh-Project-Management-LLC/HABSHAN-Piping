<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_StatusPenalty.aspx.cs" Inherits="PipingNDT_NDE_StatusPenalty" Title="NDT Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding: 5px; background-color: whitesmoke;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSave_Click" AutoPostBack="true"></telerik:RadButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Penalty Welder</td>
                <td>
                    <telerik:RadDropDownList ID="ddWelder" runat="server" DataSourceID="WeldersDataSource" DataTextField="WELDER_NO" DataValueField="WELDER_ID" Width="250px" AppendDataBoundItems="True" OnSelectedIndexChanged="ddWelder_SelectedIndexChanged" AutoPostBack="true">
                        <Items>
                            <telerik:DropDownListItem Text="Select Welder" Value="-1" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
             
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Penalty Joint 1</td>
                <td style="width: 250px;">
                   <telerik:RadComboBox ID="rcbpj1" runat="server" AllowCustomText="true" DataSourceID="Joint1DataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID" Width="250px"></telerik:RadComboBox>
                </td>
                   <td>
                    <telerik:RadButton ID="ResetPJ1" Text="Remove" runat="server" OnClick="ResetPJ1_Click" Visible="false"></telerik:RadButton>
                </td>
            </tr>
          
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Penalty Joint 2</td>
                <td>
                    <telerik:RadComboBox ID="rcbpj2" runat="server" AllowCustomText="true" DataSourceID="Joint2DataSource" DataTextField="JOINT_TITLE" DataValueField="JOINT_ID" Width="250px"></telerik:RadComboBox>
                </td>
                   <td>
                    <telerik:RadButton ID="ResetPJ2" Text="Remove" runat="server" OnClick="ResetPJ2_Click" Visible="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="WeldersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT WELDER_ID, WELDER_NO FROM VIEW_NDE_JOINT_WELDERS WHERE (NDE_ITEM_ID = :NDE_ITEM_ID) ORDER BY WELDER_NO'>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="NDE_ITEM_ID" QueryStringField="NDE_ITEM_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Joint1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT JOINT_ID, JOINT_TITLE FROM VIEW_JOINTS_SIMPLE_WELDING WHERE ((PROJ_ID = :PROJECT_ID AND WELD_DATE IS NOT NULL) and (SUB_CON_ID=:SC_ID) and (joint_id not in (select nvl(penalty_jnt1,-1) from pip_penalty_joints)) and (joint_id not in (select nvl(penalty_jnt2,-1) from pip_penalty_joints))) ORDER BY JOINT_TITLE'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="hiddenSC" DefaultValue="-1" Name="SC_ID" PropertyName="Value" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Joint2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT JOINT_ID, JOINT_TITLE FROM VIEW_JOINTS_SIMPLE_WELDING WHERE ((PROJ_ID = :PROJECT_ID AND WELD_DATE IS NOT NULL) and (SUB_CON_ID=:SC_ID)  and (joint_id not in (select nvl(penalty_jnt1,-1) from pip_penalty_joints)) and (joint_id not in (select nvl(penalty_jnt2,-1) from pip_penalty_joints))) ORDER BY JOINT_TITLE'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="hiddenSC" DefaultValue="-1" Name="SC_ID" PropertyName="Value" Type="Decimal" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="hiddenSC" runat="server"/>
</asp:Content>