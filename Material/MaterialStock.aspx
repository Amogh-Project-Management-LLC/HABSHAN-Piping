<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Theme="Blue"
    CodeFile="MaterialStock.aspx.cs" Inherits="Isome_MaterialStock" Title="Material Catalog" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnSummary" runat="server" Text="Mat Status" Width="100" OnClick="btnSummary_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRegister" runat="server" Text="New Material" Width="110"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnExport" runat="server" Text="Download" Width="110" OnClick="btnExport_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtItemCode" runat="server" AutoPostBack="True" Width="200px"
                        EmptyMessage="Search" OnTextChanged="txtItemCode_TextChanged">
                    </telerik:RadTextBox>
                </td>

            </tr>
        </table>
    </div>

    <div>
        <table style="width: 100%">
            <tr>
                <td style="vertical-align: top; width: 355px;">
                    <telerik:RadListBox ID="ListBox1" runat="server" AutoPostBack="True" DataSourceID="MatListDataSource"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Height="490px" Width="350px"
                        OnDataBound="ListBox1_DataBound" AppendDataBoundItems="True" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged">
                        <Items>
                            <telerik:RadListBoxItem Selected="true" Value="-1" Text="(Select One)" />
                        </Items>

                    </telerik:RadListBox>
                </td>
                <td style="vertical-align: top">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:DetailsView ID="StockDetailsView" runat="server" AutoGenerateRows="False" CssClass="DataWebControlStyle"
                                DataSourceID="MatStockDataSource" Width="100%" DataKeyNames="MAT_ID" SkinID="DetailsViewSkin"
                                EnableViewState="False" OnDataBound="StockDetailsView_DataBound" OnModeChanging="StockDetailsView_ModeChanging"
                                OnItemUpdating="StockDetailsView_ItemUpdating">
                                <Fields>
                                    <asp:CommandField ShowEditButton="True" ButtonType="Image" CancelImageUrl="~/Images/icon-cancel.gif"
                                        EditImageUrl="~/Images/icon-edit.gif" SelectImageUrl="~/Images/icon-select.gif"
                                        UpdateImageUrl="~/Images/icon-save.gif"></asp:CommandField>
                                    <asp:TemplateField HeaderText="Material Code1" SortExpression="MAT_CODE1">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMatcode1" runat="server" Text='<%# Bind("MAT_CODE1") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("MAT_CODE1") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Material Code2" SortExpression="MAT_CODE2">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMatcode2" runat="server" Text='<%# Bind("MAT_CODE2") %>' Width="380px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Bind("MAT_CODE2") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Size Desc" SortExpression="SIZE_DESC">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSizeDesc" BackColor="LightGray" runat="server" Text='<%# Bind("SIZE_DESC") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="txtSizeDescValidator" runat="server"
                                                ControlToValidate="txtSizeDesc" Display="Dynamic" ErrorMessage="*" BackColor="Red">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsizedesc" runat="server" Text='<%# Bind("SIZE_DESC") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Size 1" SortExpression="SIZE1">
                                        <EditItemTemplate>
                                            <telerik:RadAutoCompleteBox ID="txtSize1" runat="server" Width="200px" AutoPostBack="true"
                                                Filter="StartsWith" DataSourceID="sqlSizeMaterialSource1" DataTextField="size_1" DataValueField="size_1" InputType="Text"
                                                OnTextChanged="txtSize_TextChanged">
                                                <TextSettings SelectionMode="Single" />
                                            </telerik:RadAutoCompleteBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsize1" runat="server" Text='<%# Bind("SIZE1") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Size 2" SortExpression="SIZE2">
                                        <EditItemTemplate>
                                            <telerik:RadAutoCompleteBox ID="txtSize2" runat="server" Width="200px" AutoPostBack="true"
                                                Filter="StartsWith" DataSourceID="sqlSizeMaterialSource2" DataTextField="size_1" DataValueField="size_1" InputType="Text"
                                                OnTextChanged="txtSize_TextChanged">
                                                <TextSettings SelectionMode="Single" />
                                            </telerik:RadAutoCompleteBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSize2" runat="server" Text='<%# Bind("SIZE2") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Schedule/ Wall Thk" SortExpression="WALL_THK">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSchDesc" BackColor="LightGray" runat="server" Text='<%# Bind("WALL_THK") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="txtWallthkvalidator" runat="server"
                                                ControlToValidate="txtSchDesc" Display="Dynamic" ErrorMessage="*" BackColor="Red">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSchDesc" runat="server" Text='<%# Bind("WALL_THK") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sch1" SortExpression="THK1">
                                        <EditItemTemplate>
                                            <telerik:RadAutoCompleteBox ID="txtSch1" runat="server" Width="200px" AutoPostBack="true"
                                                Filter="StartsWith" DataSourceID="sqlSchMaterialSource" DataTextField="schedule" DataValueField="schedule" InputType="Text"
                                                OnTextChanged="txtSize_TextChanged">
                                                <TextSettings SelectionMode="Single" />
                                            </telerik:RadAutoCompleteBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsch1" runat="server" Text='<%# Bind("THK1") %>'></asp:Label>
                                        </ItemTemplate>

                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sch2" SortExpression="THK2">
                                        <EditItemTemplate>
                                            <telerik:RadAutoCompleteBox ID="txtSch2" runat="server" Width="200px" AutoPostBack="true"
                                                Filter="StartsWith" DataSourceID="sqlSchMaterialSource" DataTextField="schedule" DataValueField="schedule" InputType="Text"
                                                OnTextChanged="txtSize_TextChanged">
                                                <TextSettings SelectionMode="Single" />
                                            </telerik:RadAutoCompleteBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsch2" runat="server" Text='<%# Bind("THK2") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="UNI WEIGHT (Kg)" SortExpression="UNIT_WEIGHT">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtUnitwt" runat="server" AutoPostBack="true" Text='<%# Bind("UNIT_WEIGHT") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblwt" runat="server" Text='<%# Bind("UNIT_WEIGHT") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Item Length (mm)" SortExpression="ITEM_LENGTH">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtlength" BackColor="LightGray" runat="server" Text='<%# Bind("ITEM_LENGTH") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbllength" runat="server" Text='<%# Bind("ITEM_LENGTH") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Length1 (mm)" SortExpression="LEN1">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtlen1" runat="server" AutoPostBack="true" Text='<%# Bind("LEN1") %>' OnTextChanged="txtlen_TextChanged"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbllen1" runat="server" Text='<%# Bind("LEN1") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Length2 (mm)" SortExpression="LEN1">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtlen2" runat="server" AutoPostBack="true" Text='<%# Bind("LEN2") %>' OnTextChanged="txtlen_TextChanged"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lbllen2" runat="server" Text='<%# Bind("LEN2") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>



                                    <asp:TemplateField HeaderText="Profile" SortExpression="ITEM_PROFILE">
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList ID="ddlProfile" runat="server" SelectedValue='<%# Bind("ITEM_PROFILE") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem Value="" Text="-Select One-" />
                                                    <telerik:DropDownListItem Value="BW" Text="BW" />
                                                    <telerik:DropDownListItem Value="SW" Text="SW" />
                                                    <telerik:DropDownListItem Value="THD" Text="THD" />
                                                    <telerik:DropDownListItem Value="PE" Text="PE" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <telerik:RadLabel ID="lblprofile" runat="server" Text='<%# Bind("ITEM_PROFILE") %>' Width="77px"></telerik:RadLabel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="CREATE_DATE" HeaderText="Create Date" DataFormatString="{0:dd-MMM-yyyy}" ReadOnly="true" SortExpression="CREATE_DATE" />
                                    <asp:TemplateField HeaderText="Item Name" SortExpression="ITEM_NAM">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlitem" runat="server" DataSourceID="ItemDataSource"
                                                DataTextField="ITEM_NAM" DataValueField="ITEM_ID" SelectedValue='<%# Bind("ITEM_ID") %>'
                                                Width="150px">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ITEM_NAM") %>'></asp:TextBox>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("ITEM_NAM") %>' Width="128px"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="UOM" SortExpression="UOM">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlUOM" runat="server" DataSourceID="UomDataSource"
                                                DataTextField="UOM" DataValueField="UNIT_ID" SelectedValue='<%# Bind("UNIT_ID") %>'
                                                Width="77px">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("UOM") %>' Width="77px"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Material Type" SortExpression="MAT_TYPE">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMatType" runat="server" Text='<%# Bind("MAT_TYPE") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("MAT_TYPE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="PT CODE" SortExpression="PT_CODE">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtPtCode" runat="server" Text='<%# Bind("PT_CODE") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPtCode" runat="server" Text='<%# Bind("PT_CODE") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Class/Rating" SortExpression="CLASS">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtClass" runat="server" Text='<%# Bind("CLASS") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblClass" runat="server" Text='<%# Bind("CLASS") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="SHORT DESCR" SortExpression="SHORT_DESCR">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtShortDescr" runat="server" Text='<%# Bind("SHORT_DESCR") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblShortDescr" runat="server" Text='<%# Bind("SHORT_DESCR") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Long Description" SortExpression="MAT_DESCR">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtMatDescr" runat="server" Text='<%# Bind("MAT_DESCR") %>' Width="95%"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("MAT_DESCR") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke">
        <%--<table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnPOdepend" runat="server" Text="PO" Width="80" OnClick="btnPOdepend_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRecvd" runat="server" Text="MRV" Width="80" OnClick="btnRecvd_Click"></telerik:RadButton>
                </td>
                <td>
                     <telerik:RadButton ID="btnMRIR" runat="server" Text="MRIR" Width="80" OnClick="btnMRIR_Click"></telerik:RadButton>
                </td>
                <td>
                     <telerik:RadButton ID="btnTrans" runat="server" Text="Transfer" Width="80" OnClick="btnTrans_Click"></telerik:RadButton>
                </td>
                
                <td>
                    <telerik:RadButton ID="btnAddIssue" runat="server" Text="Add Issue" Width="80" OnClick="btnAddIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnHeatNos" runat="server" Text="Heat Nos" Width="80" OnClick="btnHeatNos_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMTC_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSplFabJC" runat="server" Text="Job Card" Width="110" OnClick="btnJC_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnJoints" runat="server" Text="Welding Joints" Width="110" OnClick="btnJoints_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnInventoryAlloc" runat="server" Text="Inventory Alloc" Width="120" OnClick="btnInventoryAlloc_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>--%>
    </div>

    <asp:ObjectDataSource ID="MatStockDataSource" runat="server" SelectMethod="GetDataByMAT_ID"
        TypeName="dsMainTablesATableAdapters.PIP_MAT_STOCKTableAdapter"
        OldValuesParameterFormatString="original_{0}" UpdateMethod="UpdateQuery">
        <SelectParameters>
            <asp:ControlParameter ControlID="ListBox1" DefaultValue="-1" Name="MAT_ID" PropertyName="SelectedValue"
                Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MAT_CODE1" Type="String" />
            <asp:Parameter Name="MAT_CODE2" Type="String" />
            <asp:Parameter Name="SIZE_DESC" Type="String" />
            <asp:Parameter Name="SIZE1" Type="String" />
            <asp:Parameter Name="SIZE2" Type="String" />
            <asp:Parameter Name="WALL_THK" Type="String" />
            <asp:Parameter Name="THK1" Type="String" />
            <asp:Parameter Name="THK2" Type="String" />
            <asp:Parameter Name="UNIT_WEIGHT" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="UNIT_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_TYPE" Type="String" />
            <asp:Parameter Name="CLASS" Type="String" />
            <asp:Parameter Name="PT_CODE" Type="String" />
            <asp:Parameter Name="SHORT_DESCR" Type="String" />
            <asp:Parameter Name="MAT_DESCR" Type="String" />
            <asp:Parameter Name="ITEM_LENGTH" Type="String" />
            <asp:Parameter Name="LEN1" Type="Decimal" />
            <asp:Parameter Name="LEN2" Type="Decimal" />
            <asp:Parameter Name="ITEM_PROFILE" Type="String" />
            <asp:Parameter Name="original_MAT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="UomDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT UNIT_ID,UOM FROM UOM_DESCR ORDER BY UOM"></asp:SqlDataSource>
    <asp:ObjectDataSource ID="MatListDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsMainTablesATableAdapters.PIP_MAT_STOCKTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtItemCode" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="~" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="ItemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT ITEM_ID, ITEM_NAM FROM PIP_MAT_ITEM ORDER BY ITEM_NAM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MatTypeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        EnableViewState="False" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT MAT_TYPE FROM PIP_MAT_TYPE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlExport" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * 
FROM VIEW_STOCK_EXPORT
ORDER BY MAT_CODE1"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSizeMaterialSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT size_1 FROM PIP_SIZE_DESCR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSizeMaterialSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT size_1 FROM PIP_SIZE_DESCR"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlSchMaterialSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT SCHEDULE FROM JOINT_SIZE_SCH"></asp:SqlDataSource>

</asp:Content>
