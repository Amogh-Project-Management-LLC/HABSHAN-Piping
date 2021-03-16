<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceiveNew.aspx.cs" Inherits="Material_MatReceiveNew" Title="MRV - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 2px;">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table class="TableStyle" style="width: 100%">
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">Subcon - Store
                </td>
                <td>
                    <telerik:RadComboBox ID="cboSubcon" runat="server" DataSourceID="sqlSubcon" DataTextField="SUB_CON_NAME"
                        DataValueField="SUB_CON_ID" OnDataBinding="cboSubcon_DataBinding" AppendDataBoundItems="true"
                        AutoPostBack="true">
                    </telerik:RadComboBox>
                    <telerik:RadComboBox ID="cboStore" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="200px" AutoPostBack="True"
                        OnSelectedIndexChanged="cboMM_SELECTedIndexChanged" OnDataBinding="cboStore_DataBinding">
                        <Items>
                            <telerik:RadComboBoxItem Selected="true" Text="(Select Store)" Value="-1"/>
                        </Items>
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">MRV Number
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReportNo" runat="server" Width="200px" ValidationGroup="a"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtReportNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="a"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">Receive Date
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
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">Receive by
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRecvby" runat="server" Width="100px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="RecvbyValidator" runat="server" ControlToValidate="txtRecvby"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">PO Number</td>
                <td>
                    <telerik:RadTextBox ID="txtPO" runat="server" EmptyMessage="Search PO.." AutoPostBack="true"></telerik:RadTextBox>
                    <telerik:RadComboBox ID="ddlPOList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlPOSource" DataTextField="PO_NO"
                        DataValueField="PO_ID" AutoPostBack="True" OnDataBinding="ddlPOList_DataBinding" Width="200px">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">SRN Number</td>
                <td>

                    <telerik:RadAutoCompleteBox ID="txtAutoSRNNo" runat="server" DataSourceID="sqlSRNSource" DataTextField="SRN_NO"
                        DataValueField="SRN_NO" DropDownHeight="300px" DropDownWidth="200px" EmptyMessage="Enter SRN Number..." MinFilterLength="1"
                        Width="200px" AllowCustomEntry="true">
                    </telerik:RadAutoCompleteBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">Shipment No
                </td>
                <td>
                    <telerik:RadTextBox ID="txtShipNo" runat="server" Width="200px" ValidationGroup="a"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="shipNoValidator" runat="server" ControlToValidate="txtShipNo"
                        ErrorMessage="*" ForeColor="Red" ValidationGroup="a"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">Supplier/Vendor
                </td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtSupplier" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 130px; background-color: whitesmoke; padding-left: 5px">Item Description
                </td>
                <td>
                    <telerik:RadTextBox runat="server" ID="txtItemDescr" Width="400px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke; padding: 2px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Create MRV" Width="120" OnClick="btnSubmit_Click" ValidationGroup="a"></telerik:RadButton>

        <telerik:RadButton ID="btnImport" runat="server" Text="Save & Import Detail" OnClick="btnImport_Click"></telerik:RadButton>
    </div>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID =:PROJECT_ID AND ( SC_ID = :SC_ID OR :SC_ID = 99 ) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlPOSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO
FROM PIP_PO 
WHERE PO_NO LIKE FNC_FILTER(:PO)">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPO" DefaultValue="XXX" Name="PO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSRNSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SRN_NO 
FROM VIEW_SRN_ITEMS
WHERE PO_ID = :PO_ID 
 ORDER BY SRN_NO
">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlPOList" DefaultValue="-1" Name="PO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSubcon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
</asp:Content>
