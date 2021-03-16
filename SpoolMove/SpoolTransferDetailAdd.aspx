<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="SpoolTransferDetailAdd.aspx.cs" Inherits="SpoolMove_SpoolTransferDetailAdd" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <asp:RadioButtonList ID="ddlAddOptions" runat="server" RepeatDirection="Horizontal" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlAddOptions_SelectedIndexChanged">
                                <asp:ListItem Text="Manual Entry" Value="MANUAL" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Import" Value="IMPORT"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDocRef" runat="server" DataSourceID="sqlDocRef" DataTextField="DOC_REF_NO"
                                DataValueField="DOC_REF_NO" Visible="false">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table runat="server" id="EntryTable" >
                    <tr>
                        <td style="width: 80px; background-color: whitesmoke; padding-left: 5px">Select Spool:</td>
                        <td style="background-color: whitesmoke">
                            <telerik:RadTextBox ID="txtSearch" runat="server" Width="150px" EmptyMessage="Search...." AutoPostBack="True"></telerik:RadTextBox>
                            <telerik:RadComboBox ID="cboSpoolList" runat="server" Width="250px" CheckBoxes="True" DataSourceID="sqlSpoolSource" DataTextField="SPL_TITLE" DataValueField="SPL_ID"></telerik:RadComboBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 80px; background-color: whitesmoke; padding-left: 5px">Remarks:</td>
                        <td>
                            <telerik:RadTextBox ID="txtRemarks" runat="server" Width="250px" TextMode="MultiLine"></telerik:RadTextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table runat="server" id="ImportTable" visible="false">
                    <tr>
                        <td>Select Import Option:</td>
                        <td>
                            <asp:RadioButtonList ID="radImportOptions" runat="server">
                                <asp:ListItem Text="Keep Existing & Import" Value="APPEND"></asp:ListItem>
                                <asp:ListItem Text="Delete Existing & Import" Value="DELETE"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <telerik:RadButton ID="btnImport" runat="server" Text="Import" Width="80px" OnClick="btnImport_Click"></telerik:RadButton>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div style="background-color: lightyellow; height: 50px; color: lightcoral; font-size: 10pt;">
                                Note:- Option 1 will keep all existing data in transfer note and import only new spools.
                                <br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                Option 2 will delete all existing data & import all data from mentioned document.
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="sqlSpoolSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT VIEW_SPOOL_TITLE.SPL_ID, VIEW_SPOOL_TITLE.SPL_TITLE FROM VIEW_SPOOL_TITLE, PIP_SPOOL WHERE VIEW_SPOOL_TITLE.SPL_ID = PIP_SPOOL.SPL_ID AND (PIP_SPOOL.SPOOL LIKE 'SPL%') AND (Nvl(PIP_SPOOL.FAB_SC, PIP_SPOOL.FIELD_SC) IN (SELECT FROM_SC FROM PIP_SPL_TRANSFER WHERE (TRANS_ID = :TRANS_ID))) AND (VIEW_SPOOL_TITLE.SPL_TITLE LIKE FNC_FILTER(:SEARCH))">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="TRANS_ID" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="SEARCH" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDocRef" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM PIP_SPL_TRANSFER_DOC
WHERE TRANS_ID = :TRANS_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="TRANS_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>