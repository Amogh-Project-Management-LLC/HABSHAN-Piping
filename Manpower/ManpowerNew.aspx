<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="ManpowerNew.aspx.cs" Inherits="Manpower_ManpowerNew" Title="Manpower" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="padding-left: 10px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <table style="width: 100%">
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Employee Code</td>
                    <td>
                        <asp:TextBox ID="txtEmpCode" runat="server" Width="200px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="EmpCodeValidator" runat="server" ControlToValidate="txtEmpCode"
                            ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Employee Name</td>
                    <td>
                        <asp:TextBox ID="txtEmpName" runat="server" Width="200px"></asp:TextBox>
                    </td>
                </tr>
                <tr>

                    <td style="width: 150px; background-color: Gainsboro;">Category</td>
                    <td>
                        <asp:DropDownList ID="ddCategory" runat="server" AppendDataBoundItems="True" DataSourceID="Category_SqlDataSource"
                            DataTextField="CATEGORY_NAME" DataValueField="CAT_ID" Width="200px">
                            <asp:ListItem Selected="True" Value="-1" Text=""></asp:ListItem>
                        </asp:DropDownList>
                        <asp:CompareValidator ID="ndetypeValidator" runat="server" ControlToValidate="ddCategory"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>

                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Subcon
                    </td>
                    <td>
                        <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource"
                            DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="200px"
                            AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" OnDataBinding="cboSubcon_DataBinding">
                        </asp:DropDownList>
                        <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                            ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <asp:SqlDataSource ID="Category_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT CAT_ID, CATEGORY_NAME FROM MANPOWER_CATEGORY ORDER BY CATEGORY_NAME'></asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>