<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_JobCard_New.aspx.cs" Inherits="Supp_JobCard_New" Title="Support Job Card" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table class="TableStyle" style="width: 100%">
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Job Card Number
                        </td>
                        <td>
                            <asp:TextBox ID="txtJcNumber" runat="server" Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="JcNumberValidator" runat="server" ControlToValidate="txtJcNumber"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Material Type</td>
                        <td>
                            <asp:DropDownList ID="ddMaterialType" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="Mat_SqlDataSource" DataTextField="MAT_TYPE" DataValueField="MAT_CODE" Width="150px" OnSelectedIndexChanged="ddMaterialType_SelectedIndexChanged">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Paint Code</td>
                        <td>
                            <asp:TextBox ID="txtPaintCode" runat="server" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="PaintCodeValidator" runat="server" ControlToValidate="txtPaintCode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Create Date </td>
                        <td>
                            <telerik:RadDatePicker ID="txtIssueDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                <calendar runat="server">
                                    <specialdays>
                                        <telerik:RadCalendarDay ItemStyle-BackColor="LightBlue" Repeatable="Today">
                                        </telerik:RadCalendarDay>
                                    </specialdays>
                                </calendar>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="IssueDateRequiredFieldValidator" runat="server" ControlToValidate="txtIssueDate" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Target Complete</td>
                        <td>
                            <telerik:RadDatePicker ID="txtTargetCmplt" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtTargetCmplt" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                        
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Sub Contractor
                        </td>
                        <td>
                            <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True"
                                DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                Width="200px">
                                <asp:ListItem Selected="True" Value="-1">(Select)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Location
                        </td>
                        <td>
                            <asp:DropDownList ID="cboShop" runat="server" DataSourceID="shopDataSource"
                                DataTextField="SHOP_NO" DataValueField="SHOP_ID" Width="200px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 140px; background-color: WhiteSmoke;">Remarks
                        </td>
                        <td>
                            <asp:TextBox ID="txtRem" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJECT_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="shopDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT SHOP_ID, SHOP_NO FROM PIP_FAB_SHOP WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY SHOP_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Mat_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_TYPE, MAT_CODE FROM PIP_SUPP_JC_MAT WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY MAT_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>