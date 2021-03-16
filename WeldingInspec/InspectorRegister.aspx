<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InspectorRegister.aspx.cs" MasterPageFile="~/PopupMasterPage.master"  Inherits="WeldingInspec_InspectorRegister" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <table>
            <tr>
               
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

     <div>
        <table>          
          <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Inspector Name
                </td>
                <td>
                    <telerik:RadTextBox ID="txtInspName" runat="server" Width="200px"></telerik:RadTextBox>
                     <asp:RequiredFieldValidator ID="NameValidator" runat="server" ControlToValidate="txtInspName"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>      
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Inspector Code
                </td>
                <td>
                    <telerik:RadTextBox ID="txtInspCode" runat="server" Width="200px"></telerik:RadTextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtInspCode"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Sub Contractor
                </td>
                <td>
                    <telerik:RadDropDownList runat="server" ID="ddlSubCon" DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:DropDownListItem  Text="Sub Contractor" Value="-1" Selected="true"/>
                        </Items>
                    </telerik:RadDropDownList>
                     <asp:CompareValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlSubCon" ValueToCompare="-1" Operator="NotEqual"
                        ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
             <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Inspector Type
                </td>
                <td>
                    <telerik:RadDropDownList runat="server" ID="ddlType" DataSourceID="InspecTypeDataSource" DataTextField="INSP_TYPE" DataValueField="TYPE_ID" AppendDataBoundItems="true">
                        <Items>
                            <telerik:DropDownListItem  Text="Type" Value="-1" Selected="true"/>
                        </Items>
                    </telerik:RadDropDownList>
                      <asp:CompareValidator ID="Typevalidator" runat="server" ControlToValidate="ddlType"
                        ErrorMessage="*" SetFocusOnError="True" ValueToCompare="-1" Operator="NotEqual" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>

            <tr>
                <td style="width: 120px; background-color: whitesmoke; padding-left: 5px">Remarks
                </td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtRemarks">            
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

     <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT SUB_CON_ID, SUB_CON_NAME 
                        FROM SUB_CONTRACTOR 
                        WHERE (PROJ_ID = :PROJECT_ID) 
                        ORDER BY SUB_CON_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="InspecTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TYPE_ID, INSP_TYPE FROM INSPECTOR_TYPE ORDER BY INSP_TYPE"></asp:SqlDataSource>
    <asp:HiddenField ID="FilterValue" runat="server" />
</asp:Content>
