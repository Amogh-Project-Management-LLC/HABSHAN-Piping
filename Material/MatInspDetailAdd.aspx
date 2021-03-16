<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="MatInspDetailAdd.aspx.cs" Inherits="Material_MatInspDetailAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
    <table>
        <tr>
            <td>Search Item</td>
            <td>:</td>
            <td colspan="3">
               
                        <telerik:RadTextBox ID="txtSearch" runat="server" Width="150px" AutoPostBack="true" EmptyMessage="Search Material here..."
                            OnTextChanged="txtSearch_TextChanged">
                        </telerik:RadTextBox>

                        <telerik:RadDropDownList ID="ddlPOItems" AutoPostBack="true" OnSelectedIndexChanged="ddlPOItems_SelectedIndexChanged" runat="server" Width="200px"
                            AppendDataBoundItems="True" DataSourceID="sqlPOItemSource" DataTextField="MAT_CODE1" DataValueField="po_item_id"
                            OnDataBinding="ddlPOItems_DataBinding" OnDataBound="ddlPOItems_DataBound">
                        </telerik:RadDropDownList>
                  

            </td>
        </tr>
        <tr>
            <td>Material Code</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtMatCode" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>PO Item No</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtPOItemNO" runat="server"></telerik:RadTextBox>
            </td>
            <td>MIR Item No</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtMIRItemNo" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>Received Qty</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtRcvQty" runat="server"></telerik:RadTextBox>
            </td>
            <td>Accept Qty</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtAcptQty" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>ESD Qty</td>
            <td>:</td>
            <td colspan="4">
                <telerik:RadTextBox ID="txtExcessQty" runat="server" Width="80px" EmptyMessage="Excess.."></telerik:RadTextBox>
                <telerik:RadTextBox ID="txtShortage" runat="server" Width="80px" EmptyMessage="Shortage.."></telerik:RadTextBox>
                <telerik:RadTextBox ID="txtDamage" runat="server" Width="80px" EmptyMessage="Damage.."></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>Heat Number</td>
            <td>:</td>
            <td>
                <telerik:RadAutoCompleteBox ID="txtAutoHeatNo" runat="server" AllowCustomEntry="True" DataSourceID="sqlHeatNo" DataTextField="HEAT_NO" DataValueField="HEAT_NO" EmptyMessage="Heat Number...." InputType="Text">
                    <TextSettings SelectionMode="Single" />
                </telerik:RadAutoCompleteBox>
            </td>
            <td>Paint System</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtPS" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td>MTC Code</td>
            <td>:</td>
            <td>
                <telerik:RadAutoCompleteBox ID="txtAutoMTCCode" runat="server" AllowCustomEntry="True" DataSourceID="sqlMTCSource" DataTextField="TC_CODE" DataValueField="TC_CODE" EmptyMessage="MTC Number...." InputType="Text">
                    <TextSettings SelectionMode="Single" />
                </telerik:RadAutoCompleteBox>
                <%--<telerik:RadTextBox ID="txtMTCCode" runat="server"></telerik:RadTextBox>
                <telerik:RadDropDownList ID="ddlMTCList" Visible="False" runat="server" AppendDataBoundItems="True" DataSourceID="sqlMTCSource" DataTextField="TC_CODE" DataValueField="TC_ID" OnDataBinding="ddlMTCList_DataBinding"></telerik:RadDropDownList>
                <telerik:RadButton ID="btnSelect" runat="server" Text="Select" OnClick="btnSelect_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnNew" runat="server" Text="New" Visible="false" OnClick="btnNew_Click"></telerik:RadButton>--%>
            </td>
          <%--  <td>As per PL Qty</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtPLQty" runat="server"></telerik:RadTextBox>
            </td>--%>
        </tr>
        <tr>
            <td>Substore/Location</td>
            <td>:</td>
            <td>
                <telerik:RadDropDownList ID="ddlSubStorList" runat="server" AppendDataBoundItems="True" DataSourceID="sqlSubstorSource" DataTextField="STORE_L1" DataValueField="SUBSTORE_ID" OnDataBinding="ddlSubStorList_DataBinding"></telerik:RadDropDownList>
            </td>
         <%--   <td>CE Value</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtCEValue" runat="server"></telerik:RadTextBox>
            </td>--%>
        </tr>
        <tr>
            <td>Unit Weight</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtUnitWt" runat="server"></telerik:RadTextBox>
            </td>
            <td>Remarks</td>
            <td>:</td>
            <td>
                <telerik:RadTextBox ID="txtRemarks" runat="server"></telerik:RadTextBox>
            </td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>
                <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100" OnClick="btnSave_Click"></telerik:RadButton>
                <telerik:RadButton ID="btnReset" runat="server" Text="Reset" Width="100"></telerik:RadButton>
            </td>

        </tr>
    </table>
    <div style="color: brown">
        <p><strong>Note:- Follow below steps in case, if material code is not appearing in Dropdown list </strong></p>
        <ul>
            <li>Check external PO link is updated or not. (Amogh Utilities page) </li>
            <li>If material is still not coming, check if mat-code is registered in Amogh (check in mat-catalog page)  </li>
            <li>If not found then register it then update the PO link again.</li>
            <li>If no PO is matching your search criteria, the PO is not updated in the external link  </li>
            <li>Ask the system administrator if any issue(s) found </li>
        </ul>
    </div>
                          </ContentTemplate>
                </asp:UpdatePanel>
    <asp:SqlDataSource ID="sqlPOItemSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_ITEM_ID, PO_ITEM || ' - ' || MAT_CODE1  AS MAT_CODE1
FROM VIEW_ADAPTER_PO_DETAIL 
WHERE PO_ID IN (SELECT PO_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID)
AND MAT_CODE1 LIKE FNC_FILTER(:FILTER)
ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ID" SessionField="popUp_MIR_ID" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="~" Name="FILTER" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlMTCSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT TC_ID, TC_CODE 
FROM PIP_TEST_CARDS
WHERE PO_ID IN (SELECT PO_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID)
ORDER BY TC_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ID" SessionField="popUp_MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSubstorSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUBSTORE_ID, STORE_L1
FROM STORES_SUB
WHERE STORE_ID IN (SELECT STORE_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID)
ORDER BY STORE_L1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="MIR_ID" SessionField="popUp_MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlHeatNo" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT HEAT_NO 
FROM PIP_TEST_CARDS_DETAIL
WHERE TC_ID IN (SELECT TC_ID FROM PIP_TEST_CARDS WHERE PO_ID = :PO_ID)
UNION
SELECT DISTINCT HEAT_NO
FROM PO_VENDOR_DATA
WHERE PO_NO IN (SELECT PO_NO FROM PIP_PO WHERE PO_ID = :PO_ID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenPO" DefaultValue="-1" Name="PO_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenPO" runat="server" />
</asp:Content>

