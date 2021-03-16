<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocTransDetail.aspx.cs"
    MasterPageFile="~/MasterPage.master" Inherits="Isome_DocTransDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <div>
            <table style="width: 100%; background-color: whitesmoke">
                <tr>
                    <td>
                        <telerik:RadLinkButton runat="server" Text="Back" Width="100" NavigateUrl="DocTrans.aspx"></telerik:RadLinkButton>
                    </td>
                    <td>
                        <telerik:RadButton ID="btnAddDoc" runat="server" Text="Add Documents" Width="150" OnClick="btnAddDoc_Click"></telerik:RadButton>
                    </td>

                    <td style="width: 100%; text-align: right"></td>
                </tr>
            </table>
        </div>

        <div>
            <table runat="server" id="EntryTable" visible="false">

                <tr>
                    <td>Document No:
                    </td>
                    <td>
                        <telerik:RadComboBox ID="ddlDocList" runat="server" DataSourceID="docListSource" DataTextField="TRANS_SUFFIX"
                            DataValueField="doc_no" CausesValidation="false" Width="250px"
                            AppendDataBoundItems="true" CheckBoxes="true" AllowCustomText="true" Filter="Contains" EnableCheckAllItemsCheckBox="true">
                        </telerik:RadComboBox>

                    </td>
                </tr>
                <tr>
                    <td>Rev No</td>
                    <td>
                        <telerik:RadTextBox ID="txtRevNo" runat="server"></telerik:RadTextBox>
                         <asp:RequiredFieldValidator ID="RevValidator" runat="server" ControlToValidate="txtRevNo"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Document Title</td>
                    <td>
                        <telerik:RadTextBox ID="txtDocTitle" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td>Code</td>
                    <td>
                        <telerik:RadTextBox ID="txtCode" runat="server"></telerik:RadTextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <telerik:RadButton ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click"></telerik:RadButton>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" DataSourceID="itemsDataSource"
                GroupPanelPosition="Top">
                <MasterTableView AutoGenerateColumns="False" DataKeyNames="TRANS_ITEM_ID" DataSourceID="itemsDataSource"
                    AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" ClientDataKeyNames="TRANS_ITEM_ID" EditMode="InPlace">
                    <Columns>
                        <%-- GRID VIEW EDIT COLUMN --%>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                            <ItemStyle CssClass="MyImageButton" Width="20px" />
                        </telerik:GridEditCommandColumn>
                        <%-- GRID VIEW COLUMN END --%>
                        <%-- GRID VIEW DELETE COLUMN --%>
                        <telerik:GridButtonColumn ConfirmText="Delete this Transmittal?" ConfirmDialogType="RadWindow"
                            ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                            UniqueName="DeleteColumn">
                            <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" Width="20px" />
                        </telerik:GridButtonColumn>
                        <%-- GRID VIEW DELETE COLUMN END --%>

                        <telerik:GridBoundColumn DataField="DOC_NO" FilterControlAltText="Filter DOC_NO column" HeaderText="DOCUMENT NO" SortExpression="DOC_NO" UniqueName="DOC_NO" ReadOnly="true">
                        </telerik:GridBoundColumn>

                        <telerik:GridBoundColumn DataField="REV_NO" FilterControlAltText="Filter REV_NO column" HeaderText="REV NO" SortExpression="REV_NO" UniqueName="REV_NO" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DOC_TITLE" FilterControlAltText="Filter DOC_TITLE column" HeaderText="DOCUMENT TITLE" SortExpression="DOC_TITLE" UniqueName="DOC_TITLE">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CODE" FilterControlAltText="Filter CODE column" HeaderText="CODE" SortExpression="CODE" UniqueName="CODE">
                        </telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>

        <asp:SqlDataSource ID="docListSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PROJECT_ID,DOC_NO,CAT_ID,TRANS_SUFFIX FROM view_master_doc_src_rev"></asp:SqlDataSource>


        <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMasterTransTableAdapters.DCS_TRANS_MASTER_DTTableAdapter" UpdateMethod="UpdateQuery">
            <DeleteParameters>
                <asp:Parameter Name="Original_TRANS_ITEM_ID" Type="Decimal" />
            </DeleteParameters>
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="-1" Name="TRANS_ID" QueryStringField="TRANS_ID" Type="Decimal" />
            </SelectParameters>
            <UpdateParameters>
              
                <asp:Parameter Name="DOC_TITLE" Type="String" />
                <asp:Parameter Name="CODE" Type="String" />
                <asp:Parameter Name="original_TRANS_ITEM_ID" Type="Decimal" />
            </UpdateParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
