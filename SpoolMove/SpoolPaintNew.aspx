<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolPaintNew.aspx.cs" Inherits="SpoolMove_SpoolPaintNew" Title="Spool Paint" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnUpdateSeqNo" runat="server" Text="Update Seq No" Width="110px" OnClick="btnUpdateSeqNo_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">Jobcard Type</td>
                <td>
                    <telerik:RadDropDownList ID="ddJobcardType" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Text="Spool Paint Jobcard" Value="PT" Selected="true" />
                            <telerik:DropDownListItem Text="SFR Job Card" Value="SF" />
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">
                    <asp:Label ID="Label1" runat="server" Text="Paint Request No"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransNo" runat="server" Width="200px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="TransNoFieldValidator" runat="server" ControlToValidate="txtTransNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">
                    <asp:Label ID="Label2" runat="server" Text="Paint Request Date"></asp:Label>
                </td>
                <td>

                    <telerik:RadDatePicker ID="txtTransDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtTransDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">
                    <asp:Label ID="Label3" runat="server" Text="Target"></asp:Label>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtTarget" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                        <Calendar runat="server">
                            <SpecialDays>
                                <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                </telerik:RadCalendarDay>
                            </SpecialDays>
                        </Calendar>
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtTarget" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">
                    <asp:Label ID="Label5" runat="server" Text="Subcon"></asp:Label>
                </td>
                <td>
                    <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                        Width="200px" OnDataBinding="cboSubcon_DataBinding" AutoPostBack="true" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged"
                        CausesValidation="false">                        
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="SubconValidator" runat="server" ControlToValidate="cboSubcon"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="(Select)" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: WhiteSmoke;">
                    <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="RALDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT RAL_NO FROM PIP_AREA_RAL_COLOUR WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY RAL_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="FinishColorDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT FINISH_COAT_CLR_CODE, FINISH_COAT_CLR_DESCR FROM PIP_AREA_RAL_COLOUR WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY FINISH_COAT_CLR_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>