<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatIssueLooseSpool.aspx.cs" Inherits="SpoolMove_MatIssueLooseSpool"
    Title="Erection/Spools" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%; background-color: whitesmoke">
                            <tr>
                                <td>
                                    <telerik:RadButton ID="btnBack" runat="server" OnClick="btnJCList_Click" Text="Back" Width="80px" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnEntryMode" runat="server" OnClick="btnEntryMode_Click" Text="Entry" Width="80px" />
                                </td>
                                <td style="width: 100%" align="center">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="10">
                                        <ProgressTemplate>
                                            <img src="../Images/ajax-loader-bar.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                                <td>
                                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                        Width="137px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid ID="ItemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                            CssClass="DataWebControlStyle" DataKeyNames="JC_ID,SPL_ID" DataSourceID="ItemsDataSource"
                            PageSize="15" Width="100%" OnDataBound="ItemsGridView_DataBound" OnRowEditing="ItemsGridView_RowEditing">
                            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                            <MasterTableView DataKeyNames="JC_ID,SPL_ID" EditMode="InPlace" AllowAutomaticUpdates="true">                               
                            <Columns>
                                <telerik:GridEditCommandColumn ButtonType="ImageButton"></telerik:GridEditCommandColumn>
                                
                                <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Spool Dwg No" SortExpression="ISO_TITLE1"
                                    ReadOnly="true" />
                                <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool Pc." SortExpression="SPOOL" ReadOnly="true" />
                                <telerik:GridBoundColumn DataField="FOREMAN_NAME" HeaderText="Foreman Name" SortExpression="FOREMAN_NAME" />
                                <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                            </Columns>                            
                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>
                        <table style="width: 100%; background-color: whitesmoke">
                            <tr>
                                <td>
                                    <telerik:RadButton ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="Delete"
                                        Width="84px" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnYes" runat="server" OnClick="btnYes_Click" Text="Yes" Visible="False"
                                        Width="43px" EnableViewState="False" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Visible="False" Width="43px" EnableViewState="False" />
                                </td>
                               
                                <td align="right" style="width: 100%">
                                    <telerik:RadTextBox EmptyMessage="Isometric No" ID="txtIsome" runat="server" AutoPostBack="True"
                                        Visible="False" Width="200px" OnTextChanged="txtIsome_TextChanged"></telerik:RadTextBox>
                                </td>
                                <td>
                                    <asp:DropDownList ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="300px">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnAddSpool" runat="server" OnClick="btnAddSpool_Click" Text="Add Spool"
                                        BackColor="SkyBlue" BorderColor="SteelBlue" Width="120px" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="ItemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsErectionTableAdapters.VIEW_SITE_JC_SPLTableAdapter"
        UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JC_ID" QueryStringField="JC_ID"
                Type="Decimal" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="Original_SPL_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ISO_REV" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="FOREMAN_NAME" Type="String" />
            <asp:Parameter Name="Original_JC_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_TOTAL_SPOOL_LIST
WHERE (PROJECT_ID = :PROJECT_ID)
AND (ISO_TITLE1 = :ISO_TITLE1)
AND (SPOOL &lt;&gt; 'EREC')
AND (SPL_ID NOT IN (SELECT SPL_ID FROM PIP_MAT_ISSUE_LOOSE_SPL))
AND ((SPL_SWN_NO IS NULL) OR (SPL_REL_NO IS NOT NULL))
AND ((HOLD_DATE IS NULL) OR (REL_DATE IS NOT NULL))
ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsome" DefaultValue="XXX" Name="ISO_TITLE1" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>