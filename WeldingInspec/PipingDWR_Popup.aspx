<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="PipingDWR_Popup.aspx.cs" Inherits="Welding_PipingDWR_Popup"
    Title="Welding Report" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <%--  <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>--%>

        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="SpoolWeldingObjectDataSource" OnItemCommand="RadGrid1_ItemCommand" OnItemDataBound="RadGrid1_ItemDataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
            <ValidationSettings EnableValidation="false" EnableModelValidation="false" ValidationGroup="New" />
            <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="False" DataKeyNames="JOINT_ID,REWORK_CODE,WELDER_ID,PASS_ID" DataSourceID="SpoolWeldingObjectDataSource"
                EditFormSettings-EditColumn-ButtonType="ImageButton" EditMode="InPlace" HierarchyLoadMode="Client" PageSize="15">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete" UniqueName="DeleteColumn">
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="REWORK_CODE" FilterControlAltText="Filter REWORK_CODE column" HeaderText="Rework Code" SortExpression="REWORK_CODE" UniqueName="REWORK_CODE" ReadOnly="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_REP_NO" ReadOnly="true" FilterControlAltText="Filter WELD_REP_NO column" HeaderText="Weld Report No" SortExpression="WELD_REP_NO" UniqueName="WELD_REP_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_DATE" ReadOnly="true" FilterControlAltText="Filter WELD_DATE column" HeaderText="Weld Date" SortExpression="WELD_DATE" UniqueName="WELD_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}">
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="WELDER_NO" FilterControlAltText="Filter WELDER_NO column" HeaderText="Welder No" SortExpression="WELDER_NO" UniqueName="WELDER_NO">
                        <EditItemTemplate>
                            <%--<asp:TextBox ID="WELDER_NOTextBox" runat="server" Text='<%# Bind("WELDER_NO") %>'></asp:TextBox>--%>
                            <telerik:RadDropDownList ID="ddlWelderEdit" runat="server" DataSourceID="sqlWelderSource" DataTextField="WELDER_NO" DataValueField="WELDER_ID"
                                SelectedValue='<%# Bind("WELDER_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="WELDER_NOLabel" runat="server" Text='<%# Eval("WELDER_NO") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="WELDER_NAME" FilterControlAltText="Filter WELDER_NAME column" HeaderText="Welder Name" SortExpression="WELDER_NAME" UniqueName="WELDER_NAME" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_PASS" ReadOnly="true" FilterControlAltText="Filter WELD_PASS column" HeaderText="Weld Pass" SortExpression="WELD_PASS" UniqueName="WELD_PASS">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WELD_PROCESS" ReadOnly="true" FilterControlAltText="Filter WELD_PROCESS column" HeaderText="Weld Process" SortExpression="WELD_PROCESS" UniqueName="WELD_PROCESS">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
        <%--    </ContentTemplate>
        </asp:UpdatePanel>--%>
    </div>

    <div id="heading_div" style="background-color:ghostwhite;">
        <span style="font:bold">Add Welders</span>
        
        <table>
            <tr>
                <td rowspan="8" style="text-align: right; vertical-align: top">
                    <table style="text-align: left; vertical-align: top">
                        <tr>
                            <td class="auto-style2">Welder</td>
                            <td>
                                <telerik:RadComboBox Skin="Windows7" ID="ddlWelder" runat="server" Width="150px" DataSourceID="welderDataSource" DataTextField="WELDER_NO"
                                    DataValueField="WELDER_ID" Filter="Contains" AllowCustomText="true" AutoPostBack="true" CausesValidation="false">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">Pass</td>
                            <td>
                                <telerik:RadDropDownList ID="ddlWelderPass" runat="server" Width="150px" DataSourceID="WeldPassDataSource" DataTextField="WELD_PASS"
                                    DataValueField="PASS_ID" AppendDataBoundItems="true">
                                    <Items>
                                        <telerik:DropDownListItem Text="Select Pass" Value="-1" />
                                    </Items>
                                </telerik:RadDropDownList>

                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadButton ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" CausesValidation="false" />
                                <telerik:RadButton ID="btnAddWelderAll" runat="server" Text="Add All" CausesValidation="false" OnClick="btnAddWelderAll_Click" />
                                <telerik:RadButton ID="btnRemove" runat="server" Text="Remove" OnClick="btnRemove_Click" CausesValidation="false" />
                                <telerik:RadButton ID="btnRemoveAll" runat="server" Text="Remove All" OnClick="btnRemoveAll_Click" CausesValidation="false" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <telerik:RadListBox ID="weldersListBox" runat="server" Width="95%" Height="150px" Style="background-color: #FFFFCC"></telerik:RadListBox>

                            </td>
                        </tr>
                         <tr>
                                        <td>
                                            <telerik:RadButton ID="WeldSave" runat="server" OnClick="WeldSave_Click" Text="Save"></telerik:RadButton>
                                        </td>
                                    </tr>
                    </table>
                </td>
            </tr>
            
        </table>
    </div>
       <telerik:RadTextBox ID="txtJoint_size" runat="server" Visible="False"></telerik:RadTextBox>
       <telerik:RadTextBox ID="txtJoint_thk" runat="server" Visible="False"></telerik:RadTextBox>
    
       <telerik:RadTextBox ID="txtWPS_ID" runat="server" Visible="False"></telerik:RadTextBox>
       <telerik:RadTextBox ID="txtSC_ID" runat="server" Visible="False"></telerik:RadTextBox>
    <asp:ObjectDataSource ID="SpoolWeldingObjectDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsWeldingATableAdapters.VIEW_SPOOL_WELDINGTableAdapter" UpdateMethod="UpdateWelder" DeleteMethod="DeleteQuery">
        <SelectParameters>
            <%--  <asp:SessionParameter DefaultValue="-1" Name="JOINT_ID" SessionField="popup_WELD_JOINT_ID" Type="Decimal" />--%>
            <asp:QueryStringParameter DefaultValue="-1" Name="JOINT_ID" QueryStringField="JOINT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
            <asp:Parameter Name="original_REWORK_CODE" Type="Object" />
            <asp:Parameter Name="original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="original_PASS_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_JOINT_ID" Type="Decimal" />
            <asp:Parameter Name="original_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="original_PASS_ID" Type="Decimal" />
            <asp:Parameter Name="original_REWORK_CODE" Type="Object" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlWelderSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT WELDER_ID, WELDER_NO
FROM PIP_WELDERS
WHERE SC_ID IN (SELECT FAB_SC 
                  FROM PIP_SPOOL 
                  WHERE SPL_ID IN (SELECT SPL_ID FROM PIP_SPOOL_JOINTS WHERE JOINT_ID = :JOINT_ID))">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="JOINT_ID" QueryStringField="JOINT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>



     <asp:SqlDataSource ID="welderDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT WELDER_ID,WELDER_NO FROM VIEW_TOTAL_WLDR_QLF 
                             WHERE :JOINT_SIZE BETWEEN SIZE_FROM AND SIZE_TO AND :JOINT_THK BETWEEN THK_FROM AND THK_TO 
                             AND (PROJECT_ID = :PROJECT_ID)  AND (WPS_NO = :WPS_ID) ORDER BY WELDER_NO">
         <%--AND (SC_ID = :SC_ID)--%>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtJoint_size" DefaultValue="-1" Name="JOINT_SIZE" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtJoint_thk" DefaultValue="-1" Name="JOINT_THK" PropertyName="Text" />
                <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />                
              
                <asp:ControlParameter ControlID="txtWPS_ID" DefaultValue="-1" Name="WPS_ID" PropertyName="Text" />          
            </SelectParameters>
        </asp:SqlDataSource>

      <asp:SqlDataSource ID="WeldPassDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
            SelectCommand="SELECT PASS_ID, WELD_PASS FROM PIP_WELDING_PASS ORDER BY PASS_ID"></asp:SqlDataSource>

</asp:Content>
