<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_StatusAdd.aspx.cs" Inherits="PipingNDT_NDE_StatusAdd" Title="NDT Status" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 150px; background-color: Gainsboro">NDT Type</td>
                <td>
                    <asp:DropDownList ID="ddNDE_Type" runat="server" Width="80px" DataSourceID="ndetypeDataSource"
                        DataTextField="NDE_TYPE" DataValueField="NDE_TYPE_ID">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Isometric No</td>
                <td>

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtIsome" runat="server" EmptyMessage="Isometric No" Width="200" OnTextChanged="txtIsome_TextChanged" AutoPostBack="true"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Joint No</td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboNewJoint" runat="server" Width="300px" DataSourceID="newjointDataSource"
                                DataTextField="JOINT_TITLE" DataValueField="JOINT_ID" AppendDataBoundItems="True" OnDataBinding="cboNewJoint_DataBinding">
                            </asp:DropDownList>

                            <asp:CompareValidator ID="JointNoCompareValidator" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="cboNewJoint" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Rework Code</td>
                <td>
                    <asp:DropDownList ID="ddReworkCode" runat="server" Width="80px" DataSourceID="ReworkCodeDataSource"
                        DataTextField="REWORK_CODE" DataValueField="REWORK_CODE" AppendDataBoundItems="True">
                        <asp:ListItem Value="-" Text="-" Selected="True"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">NDT Report No</td>
                <td>
                    <asp:TextBox ID="txtRepNo" runat="server" Width="150px"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtRepNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">NDT Date
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtNDE_Date" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Culture="en-US">
                    </telerik:RadDatePicker>

                    <asp:RequiredFieldValidator ID="NDE_DateValidator" runat="server" ControlToValidate="txtNDE_Date"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Pass Flag</td>
                <td>
                    <asp:DropDownList ID="ddPassFlag" runat="server" AppendDataBoundItems="True" DataSourceID="PassFlgDataSource"
                        DataTextField="PASS_FLG" DataValueField="PASS_FLG_ID" Width="100px">
                        <asp:ListItem Value="-1">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="PassFlagCompareValidator" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="ddPassFlag" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Total Films
                </td>
                <td>
                    <asp:TextBox ID="txtTotalFilms" runat="server" Width="80px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Repair Films
                </td>
                <td>
                    <asp:TextBox ID="txtRepairFilms" runat="server" Width="80px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Reshoot Films
                </td>
                <td>
                    <asp:TextBox ID="txtReshootFilms" runat="server" Width="80px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="passFlgField" runat="server" />
    <asp:SqlDataSource ID="PassFlgDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT PASS_FLG_ID, PASS_FLG FROM PIP_NDE_PASS_FLG'></asp:SqlDataSource>

    <asp:SqlDataSource ID="ndetypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT NDE_TYPE_ID, NDE_TYPE FROM PIP_NDE_TYPE ORDER BY NDE_TYPE'></asp:SqlDataSource>
    <asp:SqlDataSource ID="newjointDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="ReworkCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PROJECT_ID, REWORK_CODE FROM PIP_NDE_REWORK_CODE ORDER BY REWORK_CODE"></asp:SqlDataSource>
</asp:Content>