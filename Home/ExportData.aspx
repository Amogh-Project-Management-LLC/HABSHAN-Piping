<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ExportData.aspx.cs" Inherits="Home_ExportData" Title="Export Data" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .div_frame {
            width: 900px;
            padding: 5px;
            background-color: gainsboro;
            margin: 3px;
            border-radius: 5px;
            text-align: right;
        }
    </style>
    <script type="text/javascript">
       
        function ShowSelection() {
            try {
                var listbox = $find("<%= ExportsListBox1.ClientID %>");
                var items = listbox.get_selectedItems();
                for (var i = 0; i < items.length; i++) {

                    var selecteditem = items[i];
                    selecteditem.get_value();
                }
                try {
                    var combo = $find('<%=ddlSheet.ClientID %>');
                    var combo_value = combo.get_selectedItem().get_value();
                    radopen("SelectionPage.aspx?EXPT_ID=" + selecteditem.get_value() + "&SEQ=" + combo_value, "", 550, 450);

                }
                catch (err) {
                    txt = "Select Sheet Of Selection Report!";
                    alert(txt);
                }



            }
            catch (err) {
                txt = "Select any Report!";
                alert(txt + op);
            }
        }

    </script>
    <table style="width: 100%;">
        <tr>
            <td style="background-color: gainsboro;">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnPreview" runat="server" Text="Excel CSV" Width="90" OnClick="btnPreview_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnExportExcel" runat="server" Text="Zip" Width="80" OnClick="btnExportExcel_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <asp:ImageButton ID="ImageButtonProcedure" runat="server" ImageUrl="~/Images/knob/Refresh.png" ToolTip="PIVOT REFRESH" OnClick="ImageButtonProcedure_Click" Visible="false" />
                        </td>

                        <td>
                            <telerik:RadComboBox ID="ddlPdfList" runat="server" DataSourceID="ListDataSource" DataTextField="DESCRIPTION" AllowCustomText="true"
                                Filter="Contains" DataValueField="DIR_ID" Width="250px" OnSelectedIndexChanged="ddlPdfList_SelectedIndexChanged"
                                AutoPostBack="true" CausesValidation="false" EnableAutomaticLoadOnDemand="true" EmptyMessage="Select PDF Folder "
                                ItemsPerRequest="10" ShowMoreResultsBox="true" EnableVirtualScrolling="true">
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <telerik:RadComboBox ID="ddlSheet" runat="server" DataSourceID="SheetDataSource" DataTextField="REPORT_NAME" AllowCustomText="true"
                                Filter="Contains" DataValueField="SEQ" Width="250px" AutoPostBack="true" CausesValidation="false" EmptyMessage="Select Sheet" Visible="false"
                                OnSelectedIndexChanged="ddlSheet_SelectedIndexChanged">
                            </telerik:RadComboBox>

                        </td>
                        <td>

                            <asp:LinkButton ID="linkSelection" runat="server" OnClientClick="ShowSelection(); return false;" Font-Underline="false"
                                ForeColor="#003366">
                                <telerik:RadButton ID="btnSelection" runat="server" Text="Selection" Width="120px" Visible="false"></telerik:RadButton>
                            </asp:LinkButton>

                        </td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <td style="text-align: center;">
                                    <asp:Label ID="prcStatus" runat="server" Text="" Height="120%" BorderWidth="5" BorderColor="#98EDFF" BackColor="White" Width="120%" Visible="false"></asp:Label>

                                    <%--   <telerik:RadTextBox RenderMode="Lightweight" ID="prcStatus" runat="server" Width="400px" 
                                TextMode="MultiLine" Resize="None"  BorderWidth="5" BorderColor="#98EDFF" ReadOnly="true"></telerik:RadTextBox>--%>
                                </td>
                            </ContentTemplate>
                        </asp:UpdatePanel>


                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <div style="min-height: 100%; height: auto;">
                    <table>
                        <tr>
                            <td></td>
                            <td>
                                <div class="div_frame">
                                    <%--<telerik:RadTextBox ID="txtSearch" runat="server" AutoPostBack="true" EmptyMessage="Search" Width="300px" OnTextChanged="txtSearch_TextChanged"></telerik:RadTextBox>--%>
                                    <telerik:RadSearchBox RenderMode="Lightweight" runat="server" ID="txtSearch" OnSearch="txtSearch_Search"
                                        DataSourceID="SqlDataSource1" Width="300"
                                        MaxResultCount="10" EmptyMessage="Search"
                                        DataTextField="EXPT_TITLE" DataValueField="EXPT_ID">
                                        <DropDownSettings Height="400" Width="300">
                                        </DropDownSettings>
                                    </telerik:RadSearchBox>
                                </div>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td>
                                <telerik:RadListBox ID="ExportCatList" runat="server" Height="400px" Width="150px"
                                    DataSourceID="sqlExportCat" DataTextField="CAT_NAME" DataValueField="CAT_ID" AutoPostBack="true">
                                </telerik:RadListBox>
                            </td>
                            <td>
                                <telerik:RadListBox ID="ExportSubCatList" runat="server" Height="400px" Width="200px"
                                    DataSourceID="sqlExportSubCat" DataTextField="SUB_CAT_NAME" DataValueField="SUB_CAT_ID" AutoPostBack="true">
                                </telerik:RadListBox>
                            </td>
                            <td>
                                <telerik:RadListBox ID="ExportsListBox1" runat="server" AutoPostBack="true" Height="400px" Width="550px"
                                    DataSourceID="exportsDataSource" DataTextField="EXPT_TITLE" DataValueField="EXPT_ID" OnSelectedIndexChanged="ExportsListBox1_SelectedIndexChanged">
                                </telerik:RadListBox>

                            </td>

                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <td style="text-align: left;">
                                        <telerik:RadTextBox RenderMode="Lightweight" ID="SelectionStatus" runat="server" Width="200px" Height="200px" Visible="false"
                                            TextMode="MultiLine" Resize="Both" Wrap="true" BorderWidth="5" BorderColor="#98EDFF" ReadOnly="true" Font-Italic="true" Font-Size="Medium">
                                        </telerik:RadTextBox>
                                    </td>
                                    <td style="display:none">
                                        <%--auto Refresh--%>
                                        <asp:ImageButton ID="SelectionRefresh" runat="server" ImageUrl="~/Images/knob/Refresh.png" ToolTip="Selection Refresh" OnClick="SelectionRefresh_Click"  />
                                    </td>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="SelectionRefresh" />
                                </Triggers>
                            </asp:UpdatePanel>
                            
                        </tr>
                    </table>

                </div>
            </td>
        </tr>
    </table>

    <asp:SqlDataSource ID="exportsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT EXPT_ID, EXPT_TITLE FROM VIEW_IPMS_SYS_EXPORT 
                         WHERE (EXPT_TITLE LIKE FNC_FILTER(:EXPT_TITLE)) 
                         AND CAT_ID = :CAT_ID AND SUB_CAT_ID = :SUB_CAT_ID
                         AND (','||(SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0)
                     FROM dual)||',' like '%,'||cast(expt_id as varchar2(255))||',%' 
                     OR (SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0) FROM dual)='0')"
        OnSelecting="exportsDataSource_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="EXPT_TITLE" PropertyName="Text" />
            <asp:ControlParameter ControlID="ExportCatList" DefaultValue="-1" Name="CAT_ID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="ExportSubCatList" DefaultValue="-1" Name="SUB_CAT_ID" PropertyName="SelectedValue" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="OutPutDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:HiddenField ID="FileName_HiddenField" runat="server" />

    <asp:SqlDataSource ID="sqlExportCat" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT CAT_ID, CAT_NAME FROM VIEW_IPMS_SYS_EXPORT WHERE (','||(SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0)
                     FROM dual)||',' like '%,'||cast(expt_id as varchar2(255))||',%' 
                     OR (SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0) FROM dual)='0') ORDER BY CAT_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlExportSubCat" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT SUB_CAT_ID, SUB_CAT_NAME FROM VIEW_IPMS_SYS_EXPORT WHERE (','||(SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0)
                     FROM dual)||',' like '%,'||cast(expt_id as varchar2(255))||',%' 
                     OR (SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0) FROM dual)='0') AND CAT_ID= :CAT_ID
                    ORDER BY SUB_CAT_NAME">
        <SelectParameters>
            <asp:ControlParameter ControlID="ExportCatList" DefaultValue="-1" Name="CAT_ID" PropertyName="SelectedValue" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DESCRIPTION,DIR_ID FROM  DIR_OBJECTS WHERE  VISIBLE='Y' ORDER BY To_Number(DIR_ID)"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT EXPT_ID, EXPT_TITLE FROM VIEW_IPMS_SYS_EXPORT WHERE (','||(SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0)
                     FROM dual)||',' like '%,'||cast(expt_id as varchar2(255))||',%' 
                     OR (SELECT Nvl((SELECT  USER_EXPT_ID FROM  USERS WHERE USER_NAME=:USER_NAME),0) FROM dual)='0')  "
        OnSelecting="exportsDataSource_Selecting">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SheetDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand=" SELECT SEQ, REPORT_NAME FROM  SHEET_WISE_DOWNLOAD WHERE EXPT_ID=:EXPT_ID 
                        AND EXISTS (SELECT * FROM SHEET_WISE_SELECTION WHERE EXPT_ID=SHEET_WISE_DOWNLOAD.EXPT_ID
                                    AND SHEET_SEQ=SHEET_WISE_DOWNLOAD.SEQ)
                        ORDER BY SEQ">
        <SelectParameters>
            <asp:ControlParameter ControlID="ExportsListBox1" DefaultValue="-1" Name="EXPT_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
