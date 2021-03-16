<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="JobCardNew.aspx.cs" Inherits="Material_FabricationJobCardNew" Title="Jobcard - New" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>

              <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Jobcard Type</td>
                <td>
                    <telerik:RadDropDownList ID="ddJobcardType" runat="server" AppendDataBoundItems="True" DataSourceID="TypeDataSource"
                        DataTextField="WO_TYPE" DataValueField="TYPE_ID" Width="200px" OnSelectedIndexChanged="ddJobcardType_SelectedIndexChanged" AutoPostBack="true" CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Selected="True" Value="-1" Text=""></telerik:DropDownListItem>
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="JobcardTypeCompareValidator" runat="server" ControlToValidate="ddJobcardType"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="Label8" runat="server" Text="Sub Contractor"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDropDownList ID="subconDDL" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource" AutoPostBack="true"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Enabled="false" Width="200px" OnSelectedIndexChanged="subconDDL_SelectedIndexChanged" CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Value="-1" Text="Select Subcon" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="subconDDL"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="Label1" runat="server" Text="Job Card No"></telerik:RadLabel>
                </td>

                <td>
                    <telerik:RadTextBox ID="txtJcNumber" runat="server" AutoPostBack="true" BackColor="LightGray" ForeColor="Red" DisabledStyle-Font-Bold="true" Width="250px" Enabled="false"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="JcNumberValidator" runat="server" ControlToValidate="txtJcNumber"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 130px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="Label2" runat="server" Text="<%$Resources:PageLabels, IssueDate %>"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                    </telerik:RadDatePicker>
                    <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 130px; background-color: whitesmoke">
                    <telerik:RadLabel ID="RadLabel1" runat="server" Text="Revision"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRev" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="lblRev" runat="server" Text="Revision Date"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtRevDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                    </telerik:RadDatePicker>

                </td>
            </tr>

            <tr>
                <td style="width: 130px; background-color: whitesmoke;">
                    <telerik:RadLabel ID="lblTarget" runat="server" Text="Target Date"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadDatePicker ID="txtTargetDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy" Width="200px">
                    </telerik:RadDatePicker>

                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Created By
                </td>
                <td>
                    <telerik:RadDropDownList ID="createdDDL" runat="server" AppendDataBoundItems="True" DataSourceID="userDataSource"
                        DataTextField="USER_NAME" DataValueField="USER_ID" Width="200px" Enabled="false">
                    </telerik:RadDropDownList>

                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Material Type</td>
                <td>
                    <telerik:RadDropDownList ID="ddMatType" runat="server" DataSourceID="MatType_DataSource" DataTextField="MAT_GROUP" DataValueField="MAT_GROUP" Width="200px">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke;">Paint Code
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddPS" runat="server" AppendDataBoundItems="True" DataSourceID="PsDataSource"
                        DataTextField="PAINT_CODE" DataValueField="PAINT_CODE" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Selected="True" Value="" Text=""></telerik:DropDownListItem>
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="PsValidator" runat="server" ControlToValidate="ddPS"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
             <tr>
                <td style="width: 130px; background-color: whitesmoke">
                    <telerik:RadLabel ID="RadLabel2" runat="server" Text="Material Availability"></telerik:RadLabel>
                </td>
                <td>
                    <asp:RadioButtonList ID="radJCMatAvail" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="100% Available" Value="AVAILABLE" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Partial" Value="PARTIAL"></asp:ListItem>

                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke">
                    <telerik:RadLabel ID="Label9" runat="server" Text="Remarks"></telerik:RadLabel>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME,SHORT_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJ_ID) AND FAB_SC='Y' ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="TypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TYPE_ID, WO_TYPE FROM PIP_WORK_ORD_TYPE ORDER BY TYPE_ID"></asp:SqlDataSource>
    <asp:SqlDataSource ID="PsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PAINT_CODE FROM PIP_WORK_ORD_PS WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY PAINT_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="MatType_DataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_GROUP FROM PIP_MAT_TYPE WHERE (PROJ_ID = :PROJECT_ID) ORDER BY MAT_GROUP">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="userDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT USER_ID, USER_NAME FROM USERS"></asp:SqlDataSource>

      <asp:SqlDataSource ID="rangeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT RANGE_B FROM PIP_SIZE_DESCR"></asp:SqlDataSource>
</asp:Content>
