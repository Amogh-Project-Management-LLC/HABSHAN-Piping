<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV_CutPlan.aspx.cs" Inherits="Material_JC_MIV_CutPlan" Title="Cutting Plan" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .check_box {
            padding: 3px;
            background-color: whitesmoke;
            border-radius: 5px;
            margin: 2px;
            width: 300px;
        }
    </style>
    <div style="background-color: whitesmoke;">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnRandomLens" runat="server" Text="Random Lengths" Width="110" OnClick="btnRandomLens_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnRun" runat="server" Text="Run" Width="70px" OnClick="btnRun_Click" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="70px" OnClick="btnUndo_Click" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnEdit" runat="server" Text="Edit" Width="70px" Skin="Sunset" OnClick="btnEdit_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50" OnClick="btnYes_Click" EnableViewState="false" Visible="false" Skin="Sunset"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50" EnableViewState="false" Visible="false" Skin="Telerik"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="ErrorDiv" runat="server" visible="false"> 
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnPipeLenErr" runat="server" Text="Pipe Length Error" Width="120px" Skin="Sunset" OnClick="btnPipeLenErr_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPipeNotInCP" runat="server" Text="Pipe Not in Cutting Plan" Width="150px" Skin="Sunset" OnClick="btnPipeNotInCP_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 200px; background-color: whitesmoke">Pipe Lenghts
                </td>
                <td>
                    <asp:DropDownList ID="cboType" runat="server" Width="180px">
                        <asp:ListItem Value="1">Fixed Pipe Lenghts</asp:ListItem>
                        <asp:ListItem Selected="True" Value="2">Actual Pipe Lenghts</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 200px; background-color: whitesmoke">Fixed Cutting Allowance (MM)
                </td>
                <td>
                    <asp:TextBox ID="txtCuttingAlwMM" runat="server" Width="100px"></asp:TextBox>
                </td>
            </tr>
            </table>
    </div>
    <div class="check_box">
        <asp:CheckBox ID="chkUseRem" runat="server" Text="Enable Use Remain" Checked="True" />
    </div>

    <div class="check_box">
        <asp:CheckBox ID="chkUseExtra" runat="server" Text="Auto Use Extra Pipes" />
    </div>

    <div class="check_box">
        <asp:CheckBox ID="chkPipeAdj" runat="server" Text="Auto Pipe Adjustments" Enabled="False" />
    </div>
    <div>
        <asp:DropDownList ID="ddReports" runat="server" Width="250px">
            <asp:ListItem Selected="True" Value="15" Text="Cutting Plan"></asp:ListItem>
            <asp:ListItem Value="19" Text="Use Remain"></asp:ListItem>
            <asp:ListItem Value="20" Text="Remains"></asp:ListItem>
        </asp:DropDownList>
    </div>
    <div style="background-color: whitesmoke; padding: 3px; margin: 3px;">
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="modeField" runat="server" />
            <asp:HiddenField ID="woIdField" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>