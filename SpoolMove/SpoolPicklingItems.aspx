<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="SpoolPicklingItems.aspx.cs" Inherits="SpoolMove_SpoolPaintItems" Title="Spool Painting" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnJCList_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnEntryMode" runat="server" Text="New" Width="80" OnClick="btnEntryMode_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="ItemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowAutomaticDeletes="true"
            DataKeyNames="SPL_PICKLING_ID,SPL_ID" DataSourceID="ItemsDataSource" SkinID="GridViewSkin" AllowAutomaticUpdates="true"
            PageSize="20" Width="100%" OnDataBound="ItemsGridView_DataBound" OnRowEditing="ItemsGridView_RowEditing">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <MasterTableView EditMode="InPlace" DataSourceID="ItemsDataSource"  DataKeyNames="SPL_PICKLING_ID,SPL_ID">
                <Columns>
                     <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                        <ItemStyle CssClass="MyImageButton" Width="10px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmText="Delete this Spool?" ConfirmDialogType="RadWindow"
                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                        UniqueName="DeleteColumn">
                        <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="10px" />
                    </telerik:GridButtonColumn>              
                    <telerik:GridBoundColumn DataField="WORK_ORD" HeaderText="Job Card" SortExpression="WORK_ORD"
                        ReadOnly="True"></telerik:GridBoundColumn>                    
                    <telerik:GridBoundColumn DataField="SPL_TITLE" HeaderText="Spool Title" SortExpression="SPL_TITLE"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="MAT_TYPE" HeaderText="Material" SortExpression="MAT_TYPE"
                        ReadOnly="True" />
                    <telerik:GridBoundColumn DataField="PS" HeaderText="PS" SortExpression="PS" ReadOnly="True">
                        <itemstyle width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPL_SURFACE" HeaderText="SURF-m2" SortExpression="SPL_SURFACE"
                        ReadOnly="True">
                        <itemstyle width="80px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="PICKLING_REP_NO" HeaderText="Pickling Rep No" SortExpression="PICKLING_REP_NO" />
                  
                        <telerik:GridTemplateColumn AllowFiltering="False" DataField="PICKLING_DATE" DataType="System.DateTime" FilterControlAltText="Filter PICKLING_DATE column" HeaderText="Pickling Date" SortExpression="PICKLING_DATE" UniqueName="PICKLING_DATE">
                            <EditItemTemplate>
                                <telerik:RadDatePicker ID="txtPkngDate" runat="server" DbSelectedDate='<%# Bind("PICKLING_DATE") %>'
                                    Width="120px">
                                </telerik:RadDatePicker>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblPkngDate" runat="server" Text='<%# Eval("PICKLING_DATE", "{0:dd-MMM-yyyy}") %>' Width="120px"></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" />
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <div>
        <table style="width: 100%; background-color: whitesmoke;">
            <tr>
              
                <td style="width: 100%; text-align: right;">
                    <telerik:RadSearchBox EmptyMessage="Isometric No" ID="txtIsome" runat="server" AutoPostBack="True"
                        Visible="False" Width="200px" DataSourceID="sqlIsomeSource" DataTextField="ISO_TITLE1" DataValueField="ISO_TITLE1"
                        OnSearch="txtIsome_Search">
                    </telerik:RadSearchBox>
                </td>
                <td>
                    <telerik:RadComboBox ID="cboNewSpool" runat="server" DataSourceID="SpoolDataSource"
                        DataTextField="SPL_TITLE" DataValueField="SPL_ID" Visible="False" Width="300px" CheckBoxes="True"
                        EnableCheckAllItemsCheckBox="true">
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddSpool" runat="server" Text="Save" Width="80" OnClick="btnAddSpool_Click" Visible="False"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="ItemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsSpoolMoveTableAdapters.VIEW_ADAPTER_PKLNG_SPL_DETAILTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_PICKLING_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="SPL_PICKLING_ID" QueryStringField="SPL_PICKLING_ID"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PICKLING_DATE" Type="String" />
            <asp:Parameter Name="PICKLING_REP_NO" Type="String" />        
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_SPL_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPL_PICKLING_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlIsomeSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT ISO_TITLE1 FROM VIEW_ADAPTER_SPOOL WHERE FAB_SC = :FAB_SC ">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenSC" DefaultValue="-1" Name="FAB_SC" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SpoolDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SPL_ID, SPL_TITLE FROM VIEW_TOTAL_SPOOL_LIST
WHERE (PROJECT_ID = :PROJECT_ID)
AND (ISO_ID = :ISO_ID) AND SUB_CON_ID = :SUB_CON_ID
AND (SPOOL &lt;&gt; 'EREC')
AND (SPL_ID NOT IN (SELECT SPL_ID FROM PIP_PICKLING_SPL_DETAIL))
AND NDE_CMPLT IS NOT NULL
AND ((SPL_SWN_NO IS NULL) OR (SPL_SWN_NO IS NOT NULL AND SPL_REL_NO IS NOT NULL))
AND ((HOLD_DATE IS NULL) OR (HOLD_DATE IS NOT NULL AND REL_DATE IS NOT NULL))
AND NDE_CMPLT IS NOT NULL
ORDER BY SPL_TITLE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="HiddenIsoID" DefaultValue="-1" Name="ISO_ID" PropertyName="Value" />
            <asp:ControlParameter ControlID="HiddenSC" DefaultValue="-1" Name="SUB_CON_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenSC" runat="server" />
    <asp:HiddenField ID="HiddenIsoID" runat="server" />

</asp:Content>
