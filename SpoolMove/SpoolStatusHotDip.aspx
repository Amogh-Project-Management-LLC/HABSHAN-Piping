<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="SpoolStatusHotDip.aspx.cs" Inherits="SpoolMove_SpoolStatusHotDip" Title="Spool Status - Hot Dip" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <telerik:RadDatePicker ID="txtPaintDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy">
                                <Calendar runat="server">
                                    <SpecialDays>
                                        <telerik:RadCalendarDay Repeatable="Today" ItemStyle-BackColor="LightBlue">
                                        </telerik:RadCalendarDay>
                                    </SpecialDays>
                                </Calendar>
                            </telerik:RadDatePicker>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSavePaint" runat="server" Text="Save" Width="80" OnClick="btnSavePaint_Click"></telerik:RadButton>
                        </td>
                        <td style="width: 100%; text-align: right;">
                            <telerik:RadTextBox ID="txtIsomeNo" runat="server" OnTextChanged="txtIsomeNo_TextChanged"
                                Width="200px" EmptyMessage="Isometric No" AutoPostBack="True">
                            </telerik:RadTextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <div>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:GridView ID="spoolGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
                    DataSourceID="spoolsDataSource" Width="100%" AllowPaging="True" PageSize="18"
                    DataKeyNames="SPL_ID">
                    <Columns>
                        <asp:CommandField ButtonType="Image" SelectImageUrl="~/Images/icon-select.gif" ShowSelectButton="True">
                            <ItemStyle Width="30px" />
                        </asp:CommandField>
                        <asp:BoundField DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1" />
                        <asp:BoundField DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                        <asp:BoundField DataField="HOT_DIP_NEED" HeaderText="Need Hot Dip" SortExpression="HOT_DIP_NEED" />
                        <asp:BoundField DataField="HOT_DIP_DATE" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Hot Dip Date"
                            HtmlEncode="False" SortExpression="HOT_DIP_DATE" />
                    </Columns>
                    <EmptyDataTemplate>
                        No Data!
                    </EmptyDataTemplate>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:SqlDataSource ID="spoolsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID, ISO_TITLE1, ISO_REV, SHEET, SPL_ID, SPOOL, JC_NO, HOT_DIP_NEED, HOT_DIP_DATE FROM VIEW_TOTAL_SPOOL_LIST WHERE (PROJECT_ID = :PROJECT_ID) AND (ISO_TITLE1 LIKE FNC_FILTER(:ISO)) AND (FNC_IS_SPOOL(SPOOL) = 'Y') ORDER BY ISO_TITLE1, SPOOL">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsomeNo" DefaultValue="XYZ" Name="ISO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>