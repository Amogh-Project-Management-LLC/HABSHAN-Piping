<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PenaltyJointsRegist.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Penalty Joints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Back" Width="80px" OnClick="btnBack_Click" />
                <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Save" Width="80px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            Penalty Joint 1:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIsome1" runat="server" AutoPostBack="True" OnTextChanged="txtIsome1_TextChanged"
                                EmptyMessage="Isometric No" Width="200px"></telerik:RadTextBox>
                            <asp:DropDownList ID="cboJoint1" runat="server" DataSourceID="joint1DataSource" DataTextField="JOINT"
                                DataValueField="JOINT_ID" OnDataBound="cboJoint1_DataBound" Width="150px" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">UNSET</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            Penalty Joint 2:
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIsome2" runat="server" AutoPostBack="True" OnTextChanged="txtIsome2_TextChanged"
                                EmptyMessage="Isometric No" Width="200px"></telerik:RadTextBox>
                            <asp:DropDownList ID="cboJoint2" runat="server" DataSourceID="joint2DataSource" DataTextField="JOINT"
                                DataValueField="JOINT_ID" OnDataBound="cboJoint2_DataBound" Width="150px" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">UNSET</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="joint1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, SHEET || ' - ' || JNT_TITLE AS JOINT FROM VIEW_TOTAL_JOINTS &#13;&#10;WHERE (ISO_TITLE1 = :ISO) &#13;&#10;AND (WELD_DATE IS NOT NULL) &#13;&#10;AND (SUB_CON_ID = :SC_ID) &#13;&#10;AND (TRACER IS NULL OR JOINT_ID IN (SELECT PENALTY_JNT1 FROM PIP_NDE_REQUEST_JOINTS WHERE PENALTY_JNT1 = :P1))&#13;&#10;ORDER BY JOINT">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome1" DefaultValue="~" Name="ISO" PropertyName="Text" />
            <asp:ControlParameter ControlID="FieldSC_ID" DefaultValue="-1" Name="SC_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="FieldP1" DefaultValue="-1" Name="P1" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="joint2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, SHEET || ' - ' || JNT_TITLE AS JOINT FROM VIEW_TOTAL_JOINTS &#13;&#10;WHERE (ISO_TITLE1 = :ISO) &#13;&#10;AND (WELD_DATE IS NOT NULL) &#13;&#10;AND (SUB_CON_ID = :SC_ID) &#13;&#10;AND (TRACER IS NULL OR JOINT_ID IN (SELECT PENALTY_JNT2 FROM PIP_NDE_REQUEST_JOINTS WHERE PENALTY_JNT2 = :P2))&#13;&#10;ORDER BY JOINT">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome2" DefaultValue="~" Name="ISO" PropertyName="Text" />
            <asp:ControlParameter ControlID="FieldSC_ID" DefaultValue="-1" Name="SC_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="FieldP2" DefaultValue="-1" Name="P2" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="FieldSC_ID" runat="server" />
    <asp:HiddenField ID="FieldP1" runat="server" />
    <asp:HiddenField ID="FieldP2" runat="server" />
</asp:Content>
