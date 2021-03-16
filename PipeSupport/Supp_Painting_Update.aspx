<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Supp_Painting_Update.aspx.cs" Inherits="SpoolMove_SpoolStatus" Title="Spool Status" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: whitesmoke;">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <table>
                            <tr>
                                <td>
                                    <telerik:RadTextBox ID="txtPaintReportNo" runat="server" Width="150px" EmptyMessage="Paint Report No"
                                        AutoPostBack="True">
                                    </telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtPaintDate" runat="server" Width="100px" EmptyMessage="Paint Date"
                                        AutoPostBack="True">
                                    </telerik:RadTextBox>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnSavePaint" runat="server" Text="Save Paint" Width="90px" OnClick="btnSavePaint_Click" />
                                </td>
                                <td style="width: 100%" align="center">
                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="10">
                                        <ProgressTemplate>
                                            <img src="../Images/ajax-loader-bar.gif" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txtIsomeNo" runat="server" OnTextChanged="txtIsomeNo_TextChanged"
                                        Width="200px" EmptyMessage="Isometric No" AutoPostBack="True" Style="background-color: #FFFFCC">
                                    </telerik:RadTextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid ID="spoolGridView" runat="server" AutoGenerateColumns="False" CssClass="DataWebControlStyle"
                            DataSourceID="spoolsDataSource" Width="100%" AllowPaging="True" PageSize="18"
                            DataKeyNames="BOM_ID">
                            <ClientSettings Selecting-AllowRowSelect="true"></ClientSettings>
                            <MasterTableView DataKeyNames="BOM_ID">
                                <Columns>                                    
                                    <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                                    <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                                    <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                                    <telerik:GridBoundColumn DataField="PT_NO" HeaderText="PT No" SortExpression="PT_NO" />
                                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Item Code" SortExpression="MAT_CODE1" />
                                    <telerik:GridBoundColumn DataField="SF_FLG" HeaderText="SF" SortExpression="SF_FLG" />
                                    <telerik:GridBoundColumn DataField="UOM" HeaderText="UOM" SortExpression="UOM" />
                                    <telerik:GridBoundColumn DataField="NET_QTY" HeaderText="Qty" SortExpression="NET_QTY" />
                                    <telerik:GridBoundColumn DataField="SUPP_JC_NO" HeaderText="Supp JC No" SortExpression="SUPP_JC_NO" />
                                    <telerik:GridBoundColumn DataField="FAB_DATE" HeaderText="Fab Date" SortExpression="FAB_DATE"
                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                                    <telerik:GridBoundColumn DataField="PAINT_DATE" HeaderText="Paint Date" SortExpression="PAINT_DATE"
                                        DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                                    <telerik:GridBoundColumn DataField="PAINT_REP_NO" HeaderText="Paint Report No" SortExpression="PAINT_REP_NO" />
                                </Columns>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="spoolsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJ_ID, PIPING_JC_NO, ISO_TITLE1, SHEET, SPOOL, PT_NO, BOM_ID, MAT_CODE1, SF_FLG, UOM, NET_QTY, SUPP_JC_NO, FAB_DATE, PAINT_DATE, PAINT_REP_NO FROM VIEW_TOTAL_SUPP WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 LIKE FNC_FILTER(:ISO_TITLE1)) ORDER BY ISO_TITLE1, SHEET, SPOOL, MAT_CODE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsomeNo" DefaultValue="XXX" Name="ISO_TITLE1"
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
