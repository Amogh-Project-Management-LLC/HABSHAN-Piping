<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="SiteAssemblyJCRegister.aspx.cs" Inherits="Erection_ErectionRepRegister"
    Title="Flange Management" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr style="background-color: whitesmoke">
            <td>
                <table>
                    <tr>                        
                        <td>
                            <telerik:RadButton ID="txtAutoNum" runat="server" Visible="false"
                                Text="Auto Number" Width="120px" OnClick="txtAutoNum_Click" CausesValidation="False" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" 
                                Text="Submit" Width="80px" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                      <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label5" runat="server" Text="Subcontractor"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="135px" AutoPostBack="True"
                                OnSelectedIndexChanged="cboSubcon_SelectedIndexChanged" CausesValidation="false">
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label1" runat="server" Text="Issue Number"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueNumber" runat="server" Width="200px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="issueNoValidator" runat="server" ControlToValidate="txtIssueNumber"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label2" runat="server" Text="Issue Date"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="txtIssueDate" runat="server" Width="120px" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>                          
                            <asp:RequiredFieldValidator ID="issueDateValidator" runat="server" ControlToValidate="txtIssueDate"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label3" runat="server" Text="Issued by"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtIssuedBy" runat="server" Width="130px"></telerik:RadTextBox>
                            <asp:RequiredFieldValidator ID="issueByValidator" runat="server" ControlToValidate="txtIssuedBy"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                  
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            WBS/AREA
                        </td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="txtArea" runat="server" DataSourceID="sqlAreaSource" DataTextField="AREA_L1" 
                                DataValueField="AREA_L1" EmptyMessage="Start typing Area...." InputType="Text">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                        </td>
                    </tr>
                  <%--  <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            Material Type
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtMaterialType" runat="server" Width="100px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label4" runat="server" Text="Job Card Type"></asp:Label>
                        </td>
                        <td>                            
                            <asp:RadioButtonList ID="checkJCType" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="100% Material" Value="MATERIAL_AVAILABLE"></asp:ListItem>
                                <asp:ListItem Text="Partial Material" Value="PARTIAL_AVAILABLE"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>--%>
                    <tr>
                        <td style="width: 120px; background-color: whitesmoke">
                            <asp:Label ID="Label6" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="450px"></telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR &#13;&#10;WHERE (PROJ_ID = :PROJECT_ID)&#13;&#10;AND (FIELD_SC = 'Y')&#13;&#10; ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF &#13;&#10;WHERE (PROJECT_ID = :PROJECT_ID) &#13;&#10;AND (SC_ID = :SC_ID)&#13;&#10;ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAreaSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT AREA_L1 FROM IPMS_AREA ORDER BY AREA_L1"></asp:SqlDataSource>
</asp:Content>
