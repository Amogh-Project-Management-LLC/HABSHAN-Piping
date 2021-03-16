<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="NDE_StatusSegment.aspx.cs" Inherits="PipingNDT_NDE_StatusSegment" Title="NDT Segment" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding-left: 10px; background-color: whitesmoke">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSave_Click"></telerik:RadButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div>
        <table style="width: 100%">
            <tr>
                <td style="width: 150px; background-color: Gainsboro">RT Segment</td>
                <td>
                    <asp:TextBox ID="txtRT_Segment" runat="server" Width="150px"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="SegmentValidator" runat="server" ControlToValidate="txtRT_Segment"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Defect</td>
                <td>
                    <asp:DropDownList ID="ddDefect" runat="server" DataSourceID="RT_DefectDataSource"
                        DataTextField="DEFECT" DataValueField="RT_DEFECT" Width="400px" AppendDataBoundItems="True">
                        <asp:ListItem Text="XXX" Value="XXX"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Pass Flag
                </td>
                <td>
                    <asp:DropDownList ID="ddPassFlag" runat="server" AppendDataBoundItems="True" DataSourceID="PassFlgDataSource"
                        DataTextField="PASS_FLG" DataValueField="PASS_FLG_ID" Width="100px">
                        <asp:ListItem Value="-1">(Select)</asp:ListItem>
                    </asp:DropDownList>
                    <asp:CompareValidator ID="PassFlagCompareValidator" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="ddPassFlag" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Repair Length (MM)</td>
                <td>
                    <asp:TextBox ID="txtRepairLen" runat="server" Width="50px"></asp:TextBox>
                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" Enabled="True" TargetControlID="txtRepairLen" FilterType="Numbers" FilterMode="ValidChars">
                    </cc1:FilteredTextBoxExtender>
                </td>
            </tr>
            <tr>
                <td style="width: 150px; background-color: Gainsboro">Repair Welder No</td>
                <td>
                    <asp:DropDownList ID="ddWelder" runat="server" AppendDataBoundItems="True" DataSourceID="WeldersDataSource"
                        DataTextField="WELDER_NO" DataValueField="WELDER_ID" Width="150px">
                        <asp:ListItem Value="-1">(Select)</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    <div>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>

                <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="RowsObjectDataSource" CellSpacing="-1" GridLines="Both">
                    <ValidationSettings EnableValidation="false" EnableModelValidation="false" ValidationGroup="New" />
                    <MasterTableView AllowAutomaticDeletes="true" AllowAutomaticUpdates="True" DataKeyNames="NDE_ITEM_ID,RT_SEGMENT,RT_DEFECT" DataSourceID="RowsObjectDataSource"
                        EditFormSettings-EditColumn-ButtonType="ImageButton" EditMode="EditForms" HierarchyLoadMode="Client" PageSize="15">
                        <Columns>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton" ItemStyle-Width="50px" UniqueName="EditCommandColumn">
                            </telerik:GridEditCommandColumn>

                            <telerik:GridButtonColumn ConfirmText="Delete this row?" ConfirmDialogType="RadWindow"
                                ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                UniqueName="DeleteColumn" ItemStyle-Width="20px">
                            </telerik:GridButtonColumn>
                            <telerik:GridBoundColumn DataField="RT_SEGMENT" FilterControlAltText="Filter RT_SEGMENT column" HeaderText="RT Segment" SortExpression="RT_SEGMENT" UniqueName="RT_SEGMENT">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="RT_DEFECT" FilterControlAltText="Filter RT_DEFECT column" HeaderText="Defect" SortExpression="RT_DEFECT" UniqueName="RT_DEFECT">
                                <ItemTemplate>
                                    <asp:Label ID="LabelDefect" runat="server" Text='<%# Bind("RT_DEFECT") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddDefectEdit" runat="server" Width="100px"
                                        DataSourceID="RT_DefectDataSource" DataTextField="DEFECT" DataValueField="RT_DEFECT" SelectedValue='<%# Bind("RT_DEFECT") %>' AppendDataBoundItems="true">
                                        <asp:ListItem Text="XXX" Value="XXX"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="REPAIR_LEN" DataType="System.Decimal" FilterControlAltText="Filter REPAIR_LEN column" HeaderText="Repair Length" SortExpression="REPAIR_LEN" UniqueName="REPAIR_LEN">
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="WELDER_NO" FilterControlAltText="Filter WELDER_NO column" HeaderText="Welder Code" SortExpression="WELDER_NO" UniqueName="WELDER_NO">
                                <ItemTemplate>
                                    <asp:Label ID="LabelWelderNo" runat="server" Text='<%# Bind("WELDER_NO") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddWelderNoEdit" runat="server" Width="100px"
                                        DataSourceID="WeldersDataSource" DataTextField="WELDER_NO" DataValueField="WELDER_ID" SelectedValue='<%# Bind("REPAIR_WELDER_ID") %>' AppendDataBoundItems="True">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="PASS_FLG" FilterControlAltText="Filter PASS_FLG column" HeaderText="Pass Flag" SortExpression="PASS_FLG" UniqueName="PASS_FLG">
                                <ItemTemplate>
                                    <asp:Label ID="LabelPassFlag" runat="server" Text='<%# Bind("PASS_FLG") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddPassFlagEdit" runat="server" Width="100px"
                                        DataSourceID="PassFlgDataSource" DataTextField="PASS_FLG" DataValueField="PASS_FLG_ID" SelectedValue='<%# Bind("PASS_FLG_ID") %>' AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                        <EditFormSettings>
                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                </telerik:RadGrid>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:SqlDataSource ID="PassFlgDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT PASS_FLG_ID, PASS_FLG FROM PIP_NDE_PASS_FLG'></asp:SqlDataSource>
    <asp:SqlDataSource ID="RT_DefectDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT RT_DEFECT, DEFECT FROM VIEW_RT_DEFECT ORDER BY RT_DEFECT'></asp:SqlDataSource>
    <asp:SqlDataSource ID="WeldersDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT WELDER_ID, WELDER_NO FROM VIEW_NDE_JOINT_WELDERS WHERE (NDE_ITEM_ID = :NDE_ITEM_ID) ORDER BY WELDER_NO'>
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenNDE_ITEM_ID" DefaultValue="-1" Name="NDE_ITEM_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="RowsObjectDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsNDETableAdapters.VIEW_NDE_REQUEST_SEGMENTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_NDE_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_RT_SEGMENT" Type="String" />
            <asp:Parameter Name="Original_RT_DEFECT" Type="String" />
        </DeleteParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenNDE_ITEM_ID" DefaultValue="-1" Name="NDE_ITEM_ID" PropertyName="Value" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RT_SEGMENT" Type="String" />
            <asp:Parameter Name="RT_DEFECT" Type="String" />
            <asp:Parameter Name="REPAIR_LEN" Type="Decimal" />
            <asp:Parameter Name="REPAIR_WELDER_ID" Type="Decimal" />
            <asp:Parameter Name="PASS_FLG_ID" Type="Decimal" />
            <asp:Parameter Name="Original_NDE_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="Original_RT_SEGMENT" Type="String" />
            <asp:Parameter Name="Original_RT_DEFECT" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="HiddenNDE_ITEM_ID" runat="server" />
</asp:Content>