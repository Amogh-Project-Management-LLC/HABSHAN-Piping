<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="JC_MIV_MatsRegister.aspx.cs" Inherits="Material_MatReceiveNewItem"
    Title="Jobcard MIV" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <table>
            <tr>
               
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Material Code
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddlMatCode" runat="server" AppendDataBoundItems="True" DataSourceID="matDataSource" OnSelectedIndexChanged="ddlMatCode_SelectedIndexChanged"
                        DataTextField="MAT_CODE1" DataValueField="MAT_ID" Width="200px" AutoPostBack="true" CausesValidation="false">
                        <Items>
                            <telerik:DropDownListItem Text="Select Matcode" Value="-1"  Selected="true"/>
                        </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Heat No
                </td>
                <td >
                    <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataSourceID="MRIRSqlDataSource"  AppendDataBoundItems="true"
                        DataTextField="HEAT_NO" DataValueField="HEAT_NO" Width="200px" >
                       <Items>
                           <telerik:DropDownListItem Text="Select Heat No" Value="" selected="true"/>
                       </Items>
                    </telerik:RadDropDownList>
                  
                </td>
            </tr>

            <tr>
                <td style="width: 120px; background-color: whitesmoke;">MRIR No.
                </td>
                <td >
                    <telerik:RadDropDownList ID="ddlMRIRNo" runat="server" DataSourceID="MRIRSqlDataSource"  AppendDataBoundItems="true"
                        DataTextField="MIR_NO" DataValueField="MIR_ID" Width="200px">        
                        <Items>
                           <telerik:DropDownListItem Text="Select MRIR No" Value="-1" Selected="true"/>
                       </Items>
                    </telerik:RadDropDownList>
                </td>
            </tr>

              <tr>
                <td style="width: 120px; background-color: whitesmoke;">Sub Store
                </td>
                <td >
                    <telerik:RadDropDownList ID="ddlSubStore" runat="server" DataSourceID="SubStoreDataSource"  AppendDataBoundItems="true"
                        DataTextField="STORE_L1" DataValueField="SUBSTORE_ID" Width="200px">
                        <Items>
                           <telerik:DropDownListItem Text="Select Sub Strore" Value="-1"  Selected="true"/>
                       </Items>
                    </telerik:RadDropDownList>
                   
                </td>
            </tr>
            <%-- <tr>
                <td style="width: 120px; background-color: whitesmoke;">Quantity
                </td>
                <td>
                    <telerik:RadTextBox ID="txtQty" runat="server" Width="63px"></telerik:RadTextBox>
                    <asp:RequiredFieldValidator ID="qtyValidator" runat="server" ControlToValidate="txtQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>--%>
          
            <tr style="background-color:lightgray;text-decoration-color:black">
                
                <td style="width: 120px;">Required Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtReqQty" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>
                <td style="width: 120px;">Issued Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMIVIssuedQty" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>

                <td style="width: 120px;">Deleted BOM Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtDelBomQty" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>
                
               
               

            </tr>
            <tr style="background-color:lightgray">
                 <td style="width: 120px;">Balance to Issue Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtBalIssue" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>

                 <td style="width: 120px;">Can Issue Up to(Max):
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMaxQty" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>
                 <td style="width: 120px;">Subcon Stock Bal Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSubBalQty" runat="server" Width="80px" Enabled="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr >
                  <td style="width: 120px; background-color: whitesmoke;">MIV Qty
                </td>
                <td>
                    <telerik:RadTextBox ID="txtMIVQty" runat="server" Width="200px"></telerik:RadTextBox>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtMIVQty"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
              <tr id="pieces">
                <td style="width: 120px; background-color: whitesmoke;">
                   <telerik:RadLabel ID="lblPieces" Text="Pipe Pieces" runat="server" Visible="false"></telerik:RadLabel>
                </td>
                <td style="height: 25px">
                    <telerik:RadTextBox ID="txtPieces" runat="server" Width="63px" Visible="false"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="width: 120px; background-color: whitesmoke;">Remarks
                </td>
                <td>
                    <telerik:RadTextBox ID="txtRemarks" runat="server" Width="200px"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>

    <asp:SqlDataSource ID="matDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, MAT_CODE1 FROM VIEW_JC_MAT_SUMMARY WHERE (WO_ID = :WO_ID) ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="JCMIVQtyDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MAT_CODE1,DEL_BOM_QTY,REQ_QTY FROM VIEW_JC_MAT_SUMMARY WHERE (WO_ID = :WO_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="WO_ID" QueryStringField="WO_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

     <asp:SqlDataSource ID="MRIRSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISTINCT MAT_ID, HEAT_NO,MIR_ID,MIR_NO FROM VIEW_MAT_MRIR_SUMMARY WHERE (MAT_ID = :MAT_ID) AND SUB_CON_ID=:SC_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMatCode" DefaultValue="-1" Type="Decimal" Name="MAT_ID" PropertyName="SelectedValue" />
           <asp:ControlParameter DefaultValue="-1" Name="SC_ID" ControlID="hiddenSC" PropertyName="Value"/>
        </SelectParameters>
    </asp:SqlDataSource>

      <asp:SqlDataSource ID="SubStoreDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUBSTORE_ID,STORE_L1 FROM STORES_SUB WHERE  STORE_ID=:STORE_ID">
        <SelectParameters>
           <asp:ControlParameter DefaultValue="-1" Name="STORE_ID" ControlID="hiddenStore" PropertyName="Value"/>
        </SelectParameters>
    </asp:SqlDataSource>
      <asp:HiddenField ID="hiddenSC" runat="server" />
     <asp:HiddenField ID="hiddenStore" runat="server" />
</asp:Content>
