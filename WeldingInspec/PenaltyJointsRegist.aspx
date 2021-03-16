<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="PenaltyJointsRegist.aspx.cs" Inherits="WeldingInspec_PenaltyJointsRegist"
    Title="Penalty Joints" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Back" Width="74px" OnClick="btnBack_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label2" runat="server" Text="Penalty Joint 1:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIsome1" runat="server" AutoPostBack="True" OnTextChanged="txtIsome1_TextChanged"
                                Width="200px"></asp:TextBox>
                            <asp:DropDownList ID="cboJoint1" runat="server" DataSourceID="joint1DataSource" DataTextField="JOINT"
                                DataValueField="JOINT_ID" OnDataBound="cboJoint1_DataBound" Width="200px" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">UNSET</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label3" runat="server" Text="Penalty Joint 2:"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtIsome2" runat="server" AutoPostBack="True" OnTextChanged="txtIsome2_TextChanged"
                                Width="200px"></asp:TextBox>
                            <asp:DropDownList ID="cboJoint2" runat="server" DataSourceID="joint2DataSource" DataTextField="JOINT"
                                DataValueField="JOINT_ID" OnDataBound="cboJoint2_DataBound" Width="200px" AppendDataBoundItems="True">
                                <asp:ListItem Value="-1">UNSET</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Submit" Width="74px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="SC_ID_Field" runat="server" />
    <asp:HiddenField ID="P1_Field" runat="server" />
    <asp:HiddenField ID="P2_Field" runat="server" />
    <asp:SqlDataSource ID="joint1DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, SHEET || ' - ' || JNT_TITLE AS JOINT FROM VIEW_TOTAL_JOINTS 
WHERE (ISO_TITLE1 = :ISO) AND (WELD_DATE IS NOT NULL)
ORDER BY JOINT">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome1" DefaultValue="~" Name="ISO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="joint2DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOINT_ID, SHEET || ' - ' || JNT_TITLE AS JOINT FROM VIEW_TOTAL_JOINTS 
WHERE (ISO_TITLE1 = :ISO) AND (WELD_DATE IS NOT NULL)
ORDER BY JOINT">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtIsome2" DefaultValue="~" Name="ISO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
