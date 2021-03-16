<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PaintBulkMIVAdd.aspx.cs" Inherits="Painting_PaintBulkMIVAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .Heading {
            background-color: whitesmoke;
            width: 120px;
            padding-left: 5px;
        }
    </style>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
                <table>
                    <tr>
                        <td class="Heading">Sub Contractor</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlSubContractor" runat="server" AutoPostBack="True" DataSourceID="sqlSubconSource" DataTextField="SUB_CON_NAME"
                                DataValueField="SUB_CON_ID" OnDataBinding="ddlSubContractor_DataBinding" AppendDataBoundItems="true"
                                OnSelectedIndexChanged="ddlSubContractor_SelectedIndexChanged">
                            </telerik:RadDropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Issue Number</td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueNo" runat="server" Width="230px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Issue Date</td>
                        <td>
                            <telerik:RadDatePicker ID="txtIssueDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Issue By</td>
                        <td>
                            <telerik:RadTextBox ID="txtIssueBy" runat="server" Width="230px"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Heading">Bulk Paint Request</td>
                        <td>
                            <telerik:RadAutoCompleteBox ID="txtAutoBulkPaint" runat="server" Width="230px" DataSourceID="sqlBulkPaintReq" DataTextField="PAINT_REQ_NO" DataValueField="PAINT_ID" EmptyMessage="Bulk Paint Request Number......" InputType="Text">
                                <TextSettings SelectionMode="Single" />
                            </telerik:RadAutoCompleteBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="Heading">Store Name</td>
                        <td>
                            <telerik:RadDropDownList ID="ddlStoreList" runat="server" DataSourceID="sqlStoreSource" DataTextField="STORE_NAME" DataValueField="STORE_ID"></telerik:RadDropDownList>
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
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
                <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME 
FROM SUB_CONTRACTOR
ORDER BY SUB_CON_NAME"></asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME 
FROM STORES_DEF
WHERE SC_ID = :SC_ID
ORDER BY STORE_NAME">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlSubContractor" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlBulkPaintReq" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PAINT_ID, PAINT_REQ_NO
FROM VIEW_BULK_PAINT_ISSUE_BAL
WHERE SC_ID = :SC_ID 
ORDER BY PAINT_REQ_NO ">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlSubContractor" DefaultValue="-1" Name="SC_ID" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>

