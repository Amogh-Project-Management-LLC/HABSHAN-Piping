<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolReceiveNew.aspx.cs" Inherits="SpoolMove_SpoolReceiveNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            width: 120px;
            background-color: whitesmoke;
            padding-left: 5px;
        }
    </style>
    <div>
        <table>
            <tr>
                <td>Subcon</td>
                <td>
                    <telerik:RadDropDownList ID="ddlSubconList" runat="server" AppendDataBoundItems="True" DataSourceID="subconDataSource" AutoPostBack="true"
                        DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" Width="200px" OnSelectedIndexChanged="ddlSubconList_SelectedIndexChanged" CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Value="-1" Text="Select Subcon" />
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="ddlSubconList"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red" ValidationGroup="submit"></asp:CompareValidator>

                    <telerik:RadDropDownList ID="ddlStoreList" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource"
                        DataTextField="STORE_NAME" DataValueField="STORE_ID"
                        Width="200px" AutoPostBack="True" SelectedText="Select Store" OnSelectedIndexChanged="ddlStoreList_SelectedIndexChanged">
                        <Items>
                            <telerik:DropDownListItem Selected="true" Text="Select Store"  Value="-1"/>
                        </Items>
                    </telerik:RadDropDownList>
                    <asp:CompareValidator ID="storeValidator" runat="server" ControlToValidate="ddlStoreList"
                        ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1" ForeColor="Red" ValidationGroup="submit"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="Heading">Receive No</td>
                <td>
                    <telerik:RadTextBox ID="txtRCVNo" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Ship/Trailer No</td>
                <td>
                    <telerik:RadTextBox ID="txtShipNo" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Receive Date</td>
                <td>
                    <telerik:RadDatePicker ID="txtReceiveDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="Heading">Receive By</td>
                <td>
                    <telerik:RadTextBox ID="txtReceiveBy" runat="server" Width="230px" ReadOnly="true"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Transfer No</td>
                <td>
                    <telerik:RadComboBox ID="cboTransfer" runat="server" DataSourceID="transferDataSource" DataTextField="TRANS_NO" DataValueField="TRANS_ID" AutoPostBack="true"
                        Filter="Contains" Width="300px" OnDataBinding="cboTransfer_DataBinding" ValidationGroup="submit" OnSelectedIndexChanged="cboTransfer_SelectedIndexChanged" AppendDataBoundItems="true">
                    </telerik:RadComboBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Transfer Reason</td>
                <td>
                    <telerik:RadTextBox ID="txtTransReason" runat="server" Width="230px" ReadOnly="true" BackColor="Gainsboro"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Container No</td>
                <td>
                    <telerik:RadTextBox ID="txtContainerNo" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td class="Heading">Remarks</td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="230px"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <telerik:RadButton ID="btnSave" runat="server" Width="80px" Text="Save" OnClick="btnSave_Click" ValidationGroup="submit"></telerik:RadButton>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="transferDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
            SelectCommand="SELECT TRANS_ID, TRANS_NO FROM PIP_SPL_TRANSFER WHERE (PROJECT_ID = :PROJECT_ID) AND (TO_SC = :TO_SUB_CON_ID) ORDER BY TRANS_NO">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                <asp:ControlParameter ControlID="ddlSubconList" DefaultValue="-1" Name="TO_SUB_CON_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="subconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_NAME, SUB_CON_ID
FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
        <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM STORES_DEF WHERE SC_ID=:SC_ID">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlSubconList" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
