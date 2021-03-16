<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_MatRegist.aspx.cs" Inherits="Erection_Additional_Mat_Regist"
    Title="Additional Issue" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label1" runat="server" Text="Issue Number"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueNo" runat="server" Width="200px" EmptyMessage="Select Subcon"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtIssueNo"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">Material Scope</td>
                        <td>
                            <telerik:RadDropDownList ID="ddScope" runat="server" DataSourceID="Scope_SqlDataSource" DataTextField="MAT_SCOPE" DataValueField="MAT_SCOPE_CODE" Width="150px">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label2" runat="server" Text="Issued Date"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label3" runat="server" Text="Issued by"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueby" runat="server" Width="140px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtIssueby"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label4" runat="server" Text="Subcon"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                                Width="180px" AutoPostBack="True" OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged"
                                OnDataBinding="cboSubcon_DataBinding" CausesValidation="false">                                                                
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label5" runat="server" Text="Category"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboCategory" runat="server" DataSourceID="catDataSource" DataTextField="CATEGORY"
                                DataValueField="CAT_ID" Width="180px" AppendDataBoundItems="True" OnDataBinding="cboCategory_DataBinding">                                
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="cboCategory"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label6" runat="server" Text="From Store"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="180px" OnDataBinding="cboStore_DataBinding">                               
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="cboStore"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: whitesmoke">
                            <asp:Label ID="Label7" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: gainsboro">
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF &#13;&#10;WHERE (PROJECT_ID = :PROJECT_ID)&#13;&#10;AND (SC_ID = :SC_ID)&#13;&#10;ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="catDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "CAT_ID", "CATEGORY" FROM "PIP_MAT_ISSUE_ADD_CAT"'></asp:SqlDataSource>
    <asp:SqlDataSource ID="Scope_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_SCOPE_CODE, MAT_SCOPE FROM MATERIAL_SCOPE WHERE (PROJECT_ID = :PROJECT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>