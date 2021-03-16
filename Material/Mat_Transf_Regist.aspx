<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mat_Transf_Regist.aspx.cs" Inherits="Erection_Additional_Mat_Regist"
    Title="Material Transfer - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: gainsboro;">
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Transfer No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtTransfNo" runat="server" Width="250px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="transfNoValidator" runat="server" ControlToValidate="txtTransfNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Create Date
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
                <td style="width: 120px; background-color: whitesmoke">Scope</td>
                <td>
                    <telerik:RadDropDownList ID="ddScope" runat="server" DataSourceID="Scope_SqlDataSource" DataTextField="MAT_SCOPE" DataValueField="MAT_SCOPE_CODE" 
                        Width="150px" OnDataBinding="ddScope_DataBinding" AppendDataBoundItems="true">
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Create by
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCreateBy" runat="server" Width="250px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="CreateByValidator" runat="server" ControlToValidate="txtCreateBy"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">From Store
                </td>
                <td>

                    <telerik:RadDropDownList ID="ddFrom" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="250px" OnDataBinding="ddFrom_DataBinding"
                        AutoPostBack="true" OnSelectedIndexChanged="ddFrom_SelectedIndexChanged" CausesValidation="false">                        
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="fromValidator" runat="server" ControlToValidate="ddFrom"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">To Store
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddTo" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="250px" OnDataBinding="ddTo_DataBinding" AutoPostBack="true"
                        OnSelectedIndexChanged="ddTo_SelectedIndexChanged">                        
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="toValidator" runat="server" ControlToValidate="ddTo" ErrorMessage="*"
                        Operator="NotEqual" ValueToCompare="-1" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="lblTransCat" runat="server" Text="Transfer Type"></asp:Label>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlTransType" runat="server" AutoPostBack="True" AppendDataBoundItems="True" OnDataBinding="ddlTransType_DataBinding" 
                        Width="250px" DataSourceID="sqlTransType" DataTextField="CAT_NAME" DataValueField="CAT_ID" CausesValidation="false" 
                        OnSelectedIndexChanged="ddlTransType_SelectedIndexChanged"></telerik:RadDropDownList>                    
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">
                    <asp:Label ID="lblTransDoc" runat="server" Text="Document Ref No" Visible="false"></asp:Label>
                </td>
                <td>
                    <telerik:RadComboBox ID="ddlTransDocName" runat="server" Width="250px" Visible="false" DataSourceID="sqlDocumentSource"
                         DataTextField="DOC_NAME" DataValueField="DOC_NAME" AppendDataBoundItems="true" OnDataBinding="ddlTransDocName_DataBinding"></telerik:RadComboBox>
                        <telerik:RadLabel ID="lblMessage" runat="server" Text=""></telerik:RadLabel>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="350px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    

    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF
WHERE (PROJECT_ID = :PROJECT_ID)
ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Scope_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MAT_SCOPE_CODE, MAT_SCOPE FROM MATERIAL_SCOPE WHERE (PROJECT_ID = :PROJECT_ID)'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlTransType" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM PIP_MAT_TRANSF_TYPE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDocumentSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    
</asp:Content>