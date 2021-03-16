<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatInspAdd.aspx.cs" Inherits="Material_MatInspAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Title {
            width: 120px;
            padding-left: 10px;
        }

        .RightTitle {
            width: 120px;
            padding-left: 20px;
        }
    </style>
  <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <div>
                <table>
                    <tr>
                        <td class="Title">Subcontractor</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlSubcon" runat="server" Width="200px" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="sqlSrcSubcon" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBinding="ddlSubcon_DataBinding" OnSelectedIndexChanged="ddlSubcon_SelectedIndexChanged"></telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">MRIR No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtMIRNo" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Inspection Date</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtInspDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"></telerik:RadDatePicker>
                        </td>
                        <td class="RightTitle">Received Date</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDatePicker ID="txtRecvdDate" DateInput-DateFormat="dd-MMM-yyyy" runat="server"></telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">MRV No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtMRVSearch" EmptyMessage="Search MRV Number" runat="server" Width="200px" AutoPostBack="True"
                                 ></telerik:RadTextBox>
                        </td>
                        <td class="RightTitle">Received By</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtRcvBy" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title"></td>
                        <td></td>
                        <td>
                            <telerik:RadDropDownList ID="ddlMRVList" runat="server" Width="200px" DataSourceID="sqlSrcMRV" DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID" 
                                 AppendDataBoundItems="True" OnDataBinding="ddlMRVList_DataBinding" OnSelectedIndexChanged="ddlMRVList_SelectedIndexChanged"
                                 AutoPostBack="true"></telerik:RadDropDownList>
                        </td>
                    </tr>                  
                    <tr>
                        <td class="Title">PO Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtPOSearch" EmptyMessage="Search PO Number" runat="server" Width="200px" AutoPostBack="True"></telerik:RadTextBox>
                        </td>
                        <td class="RightTitle">SRN Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="txtAutoSRNNo" runat="server" DataSourceID="sqlSRNSource" DataTextField="SRN_NO" 
                                DataValueField="SRN_NO" Width="200px" AllowCustomEntry="true"></telerik:RadAutoCompleteBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title"></td>
                        <td></td>
                        <td>
                            <telerik:RadDropDownList ID="ddlPOList" runat="server" Width="200px" DataSourceID="sqlSrcPO" DataTextField="PO_NO" DataValueField="PO_ID" 
                                AppendDataBoundItems="True" OnDataBinding="ddlPOList_DataBinding" OnDataBound="ddlPOList_DataBound" 
                                AutoPostBack="True" OnSelectedIndexChanged="ddlPOList_SelectedIndexChanged"></telerik:RadDropDownList>
                        </td>
                        <td class="RightTitle">Ship Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtShipNumber" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Received At Store</td>
                        <td>:</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlStoreList" runat="server" Width="200px" DataSourceID="sqlSrcStore" DataTextField="STORE_NAME" DataValueField="STORE_ID" EnableVirtualScrolling="True"></telerik:RadDropDownList>
                        </td>
                        <td class="RightTitle">Shipment Mode</td>
                        <td>:</td>
                        <td>
                            <asp:RadioButtonList ID="rdbShipMode" runat="server" RepeatDirection="Horizontal">
                                <asp:ListItem Text="Sea"></asp:ListItem>
                                <asp:ListItem Text="Land"></asp:ListItem>
                                <asp:ListItem Text="Air Freight"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Invoice Number</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtInvoiceNo" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                        <td class="RightTitle">Packing List No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtPackingList" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Supplier/Vendor</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtSupplier" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                        <td class="RightTitle">AWB/BL/TWB No</td>
                        <td>:</td>
                        <td>
                            <telerik:RadTextBox ID="txtAWBBLTWB" runat="server" Width="200px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Title">Remarks</td>
                        <td>:</td>
                        <td colspan="4">
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="550px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td colspan="4">
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click"></telerik:RadButton>
                            <telerik:RadButton ID="btnReset" runat="server" Text="Reset" Width="100px"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <asp:SqlDataSource ID="sqlSrcSubcon" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSrcMRV" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_RCV_ID, MAT_RCV_NO FROM PIP_MAT_RECEIVE WHERE MAT_RCV_NO LIKE FNC_FILTER(:FILTER) AND STORE_ID IN (SELECT STORE_ID FROM STORES_DEF WHERE SC_ID = :SC_ID) ORDER BY MAT_RCV_NO">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtMRVSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" />
                    <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSrcPO" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ID, PO_NO FROM PIP_PO WHERE PO_NO LIKE FNC_FILTER(:FILTER) AND PROJECT_ID = :PROJECT_ID ORDER BY PO_NO ">
                <SelectParameters>
                    <asp:ControlParameter ControlID="txtPOSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" />
                    <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlSrcStore" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM STORES_DEF WHERE SC_ID = :SC_ID ORDER BY STORE_NAME">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlSubcon" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSRNSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SRN_NO
FROM VIEW_SRN_ITEMS_MIR
WHERE PO_ID = :PO_ID
ORDER BY SRN_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlPOList" DefaultValue="-1" Name="PO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>


</asp:Content>

