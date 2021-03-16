<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="RemainWorkPunch.aspx.cs" Inherits="Erection_RemainWorkPunch" Title="Remaining Work" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%; background-color: whitesmoke">
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" CausesValidation="False" OnClick="btnBack_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNew" runat="server" Text="New" Width="80px" CausesValidation="False" OnClick="btnNew_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" Visible="False" OnClick="btnSave_Click" />
                        </td>
                        <td style="width: 100%" align="right">
                            <telerik:RadTextBox EmptyMessage="Search Here" ID="txtSearch" runat="server" Width="212px"
                                AutoPostBack="True">
                            </telerik:RadTextBox>
                        </td>
                        <td>
                            <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                                Width="120px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table id="EntryTable" runat="server" width="100%" visible="false">
                    <tr>
                        <td style="width: 110px; background-color: whitesmoke">Jobcard No
                        </td>
                        <td>
                            <asp:DropDownList ID="ddJC_NO" runat="server" Width="200px" AppendDataBoundItems="True"
                                DataSourceID="JobCardDataSource" DataTextField="ISSUE_NO" DataValueField="JC_ID"
                                OnDataBinding="ddJC_NO_DataBinding">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="JobCardNoValidator" runat="server" ControlToValidate="ddJC_NO"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Subcon
                        </td>
                        <td>
                            <asp:DropDownList ID="ddSubcon" runat="server" Width="200px" AppendDataBoundItems="True"
                                DataSourceID="SubconDataSource" DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID"
                                OnDataBinding="ddSubcon_DataBinding">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="SubconValidator" runat="server" ControlToValidate="ddSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Isometric No
                        </td>
                        <td>
                            <asp:TextBox ID="txtIsomeFilter" runat="server" AutoPostBack="True" Width="200px"
                                OnTextChanged="txtIsomeFilter_TextChanged"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Isometric No
                        </td>
                        <td>
                            <asp:DropDownList ID="cboIsome" runat="server" AppendDataBoundItems="True" DataSourceID="IsomeDataSource"
                                DataTextField="ISO_TITLE1" DataValueField="ISO_ID" Width="250px" OnDataBinding="cboIsome_DataBinding"
                                AutoPostBack="True">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="isomeValidator" runat="server" ControlToValidate="cboIsome"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">BOM Item
                        </td>
                        <td>
                            <asp:DropDownList ID="cboBOM" runat="server" AppendDataBoundItems="True" DataSourceID="bomDataSource"
                                DataTextField="BOM_ITEM" DataValueField="BOM_ID" Width="332px" AutoPostBack="True"
                                OnSelectedIndexChanged="cboMM_SELECTedIndexChanged">
                                <asp:ListItem Selected="True" Value="-1">(Select One)</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Sheet No
                        </td>
                        <td>
                            <asp:DropDownList ID="ddSheetNo" runat="server" Width="80px" AppendDataBoundItems="True"
                                OnDataBinding="ddSheetNo_DataBinding" DataSourceID="SheetNoDataSource" DataTextField="SHEET"
                                DataValueField="SHEET">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="SheetNoValidator" runat="server" ControlToValidate="ddSheetNo"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Spool
                        </td>
                        <td>
                            <asp:DropDownList ID="ddSpool" runat="server" Width="80px" AppendDataBoundItems="True"
                                OnDataBinding="ddSpool_DataBinding" DataSourceID="SpoolDataSource" DataTextField="SPOOL"
                                DataValueField="SPOOL">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="SpoolValidator" runat="server" ControlToValidate="ddSpool"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Punch Code
                        </td>
                        <td>
                            <asp:DropDownList ID="ddPunchCode" runat="server" Width="120px" DataSourceID="punchCodeDataSource"
                                DataTextField="PUNCH_CODE" DataValueField="PUNCH_DESCR" AppendDataBoundItems="True"
                                OnDataBinding="ddPunchCode_DataBinding" AutoPostBack="True" OnSelectedIndexChanged="ddPunchCode_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="PunchCodeValidator" runat="server" ControlToValidate="ddPunchCode"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Punch Category
                        </td>
                        <td>
                            <asp:DropDownList ID="ddPunchCat" runat="server" Width="120px" DataSourceID="punchCatDataSource"
                                DataTextField="PUNCH_CAT" DataValueField="PUNCH_CAT">
                            </asp:DropDownList>
                            <asp:CompareValidator ID="PunchCatValidator" runat="server" ControlToValidate="ddPunchCat"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Item Description
                        </td>
                        <td>
                            <asp:TextBox ID="txtDesc" runat="server" Width="550px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="DescFieldValidator" runat="server" ControlToValidate="txtDesc"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr style="color: #000000">
                        <td style="width: 110px; background-color: whitesmoke">Remarks
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="550px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="welderGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CssClass="DataWebControlStyle" DataKeyNames="REM_WORK_ID" DataSourceID="ItemsDataSource"
                    PageSize="15" OnRowUpdating="welderGridView_RowUpdating" Width="100%" OnDataBound="welderGridView_DataBound">
                    <MasterTableView DataKeyNames="REM_WORK_ID" AllowAutomaticUpdates="true" EditMode="InPlace">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="20px" />
                            </telerik:GridEditCommandColumn>                            
                            <telerik:GridBoundColumn DataField="ISSUE_NO" HeaderText="Issue No" SortExpression="ISSUE_NO"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SUB_CON_NAME" HeaderText="Subcon" SortExpression="SUB_CON_NAME"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="ISO_TITLE1" HeaderText="Isometric No" SortExpression="ISO_TITLE1"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="SHEET" HeaderText="Sheet" SortExpression="SHEET" />
                            <telerik:GridBoundColumn DataField="SPOOL" HeaderText="Spool" SortExpression="SPOOL" />
                            <telerik:GridBoundColumn DataField="PUNCH_CODE" HeaderText="Punch Code" SortExpression="PUNCH_CODE" />
                            <telerik:GridBoundColumn DataField="PUNCH_CAT" HeaderText="Punch Cat" SortExpression="PUNCH_CAT" />
                            <telerik:GridBoundColumn DataField="ITEM_DESC" HeaderText="Item Desc" SortExpression="ITEM_DESC" />
                            <telerik:GridBoundColumn DataField="PT_NO" HeaderText="Part No" SortExpression="PT_NO" ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="Mat Code" SortExpression="MAT_CODE1"
                                ReadOnly="true" />
                            <telerik:GridBoundColumn DataField="CHECKED_BY" HeaderText="Checked By" SortExpression="CHECKED_BY" />
                            <telerik:GridBoundColumn DataField="COMPLT_DATE" HeaderText="Complt Date" SortExpression="COMPLT_DATE"
                                DataFormatString="{0:dd-MMM-yyyy}" HtmlEncode="false" />
                            <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                        </Columns>
                    </MasterTableView>
                </telerik:RadGrid>
            </td>
        </tr>
        <tr>
            <td style="background-color: whitesmoke">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnDelete" runat="server" Width="81px" Text="Delete" OnClick="btnDelete_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnYes" runat="server" EnableViewState="False" Text="Yes" Visible="False"
                                Width="38px" OnClick="btnYes_Click" />
                        </td>
                        <td>
                            <telerik:RadButton ID="btnNo" runat="server" EnableViewState="False" Text="No" Visible="False"
                                Width="38px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="ItemsDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsErectionATableAdapters.VIEW_SITE_REMAINING_WORKTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <UpdateParameters>
            <asp:Parameter Name="SHEET" Type="String" />
            <asp:Parameter Name="PUNCH_CODE" Type="String" />
            <asp:Parameter Name="ITEM_DESC" Type="String" />
            <asp:Parameter Name="CHECKED_BY" Type="String" />
            <asp:Parameter Name="COMPLT_DATE" Type="DateTime" />
            <asp:Parameter Name="PUNCH_CAT" Type="String" />
            <asp:Parameter Name="SPOOL" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_REM_WORK_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="ISO_TITLE1" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_REM_WORK_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="JobCardDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JC_ID, ISSUE_NO FROM PIP_MAT_ISSUE_LOOSE WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY ISSUE_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE (PROJ_ID = :PROJ_ID) ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="IsomeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        OldValuesParameterFormatString="original_{0}" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ISO_ID, ISO_TITLE1 FROM PIP_ISOMETRIC WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_TITLE1 LIKE FNC_FILTER(:ISO)) ORDER BY ISO_TITLE1">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="txtIsomeFilter" DefaultValue="~" Name="ISO" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SheetNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SHEET FROM PIP_SPOOL WHERE (ISO_ID = :ISO_ID) ORDER BY SHEET">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboIsome" DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SPOOL FROM PIP_SPOOL WHERE (ISO_ID = :ISO_ID) ORDER BY SPOOL">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboIsome" DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="bomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT BOM_ID, BOM_ITEM FROM VIEW_BOM_EREC_ITEM WHERE (PROJ_ID = :PROJECT_ID) AND (ISO_ID = :ISO_ID) AND (SF = 2) ORDER BY BOM_ITEM">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="cboIsome" DefaultValue="-1" Name="ISO_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="punchCodeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        OnSelecting="SqlDataSource1_Selecting" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT PUNCH_CODE, PUNCH_DESCR FROM REM_WORK_PUNCH_CODE ORDER BY PUNCH_CODE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="punchCatDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT PUNCH_CAT FROM REM_WORK_PUNCH_CODE ORDER BY PUNCH_CAT"></asp:SqlDataSource>
</asp:Content>
