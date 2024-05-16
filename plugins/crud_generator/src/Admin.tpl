<?php
namespace Plugins\MODULE_NAME;

use Systems\AdminModule;

class Admin extends AdminModule
{

    public function navigation()
    {
        return [
            'Kelola'   => 'manage',
        ];
    }

    public function getManage(){
        $this->_addHeaderFiles();
        return $this->draw('manage.html');
    }

    public function postData(){
        $draw = $_POST['draw'];
        $row1 = $_POST['start'];
        $rowperpage = $_POST['length']; // Rows display per page
        $columnIndex = $_POST['order'][0]['column']; // Column index
        $columnName = $_POST['columns'][$columnIndex]['data']; // Column name
        $columnSortOrder = $_POST['order'][0]['dir']; // asc or desc
        $searchValue = $_POST['search']['value']; // Search value

        ## Custom Field value
        $search_field_$$$$= $_POST['search_field_$$$$'];
        $search_text_$$$$ = $_POST['search_text_$$$$'];

        $searchQuery = " ";
        if($search_text_$$$$ != ''){
            $searchQuery .= " and (".$search_field_$$$$." like '%".$search_text_$$$$."%' ) ";
        }

        ## Total number of records without filtering
        $sel = $this->db()->pdo()->prepare("select count(*) as allcount from $$$$");
        $sel->execute();
        $records = $sel->fetch();
        $totalRecords = $records['allcount'];

        ## Total number of records with filtering
        $sel = $this->db()->pdo()->prepare("select count(*) as allcount from $$$$ WHERE 1 ".$searchQuery);
        $sel->execute();
        $records = $sel->fetch();
        $totalRecordwithFilter = $records['allcount'];

        ## Fetch records
        $sel = $this->db()->pdo()->prepare("select * from $$$$ WHERE 1 ".$searchQuery." order by ".$columnName." ".$columnSortOrder." limit ".$row1.",".$rowperpage);
        $sel->execute();
        $result = $sel->fetchAll(\PDO::FETCH_ASSOC);

        $data = array();
        foreach($result as $row) {
            $data[] = array(
                ISI_LOAD_DATA
            );
        }

        ## Response
        $response = array(
            "draw" => intval($draw), 
            "iTotalRecords" => $totalRecords,
            "iTotalDisplayRecords" => $totalRecordwithFilter,
            "aaData" => $data
        );

        echo json_encode($response);
        exit();
    }

    public function postAksi()
    {
        if(isset($_POST['typeact'])){ 
            $act = $_POST['typeact']; 
        }else{ 
            $act = ''; 
        }

        if ($act=='add') {

        POST_VARIABLE
            
            $NAMA_TABLE_add = $this->db()->pdo()->prepare('INSERT INTO NAMA_TABLE VALUES (TEMPAT_VALUES)');
            $NAMA_TABLE_add->execute([ISI_VALUES]);

        }
        if ($act=="edit") {

        POST_VARIABLE

        // BUANG FIELD PERTAMA

            $NAMA_TABLE_edit = $this->db()->pdo()->prepare("UPDATE NAMA_TABLE SET VALUES_EDIT WHERE WHERE_EDIT");
            $NAMA_TABLE_edit->execute([VALUES_ISI_EDIT]);
        
        }

        if ($act=="del") {
        POST_DELETE
            $result = $this->db()->pdo()->exec("DELETE FROM NAMA_TABLE WHERE WHERE_DELETE");            
        }

        if ($act=="lihat") {

            $search_field_NAMA_TABLE = $_POST['search_field'];
            $search_text_NAMA_TABLE = $_POST['search_value'];
            
            $user_lihat = $this->db()->pdo()->prepare("SELECT * from NAMA_TABLE WHERE 1 and (".$search_field_NAMA_TABLE." like '%".$search_text_NAMA_TABLE."%')");
            $user_lihat->execute();
            $result = $user_lihat->fetchAll(\PDO::FETCH_ASSOC);

            $data = array();

            foreach($result as $row) {
                $data[] = array(
                    LIHAT_ISI
                );
            }

            echo json_encode($data);
        }
        exit();
    }

    public function getCss()
    {
        header('Content-type: text/css');
        echo $this->draw(MODULES.'/NAMA_TABLE/css/admin/styles.css');
        exit();
    }

    public function getJavascript()
    {
        header('Content-type: text/javascript');
        echo $this->draw(MODULES.'/NAMA_TABLE/js/admin/scripts.js');
        exit();
    }

    private function _addHeaderFiles()
    {
        $this->core->addCSS(url('assets/datatables/css/jquery.dataTables.min.css'));
        $this->core->addCSS(url('assets/css/dataTables.bootstrap.min.css'));
        $this->core->addCSS(url('assets/datatables/css/buttons.dataTables.min.css'));

        $this->core->addJS(url('assets/jscripts/jqueryvalidation.js'));
        $this->core->addJS(url('assets/export/xlsx.js'));
        $this->core->addJS(url('assets/export/jspdf.min.js'));
        $this->core->addJS(url('assets/export/jspdf.plugin.autotable.min.js'));
        $this->core->addJS(url('assets/export/umum.js'));
        $this->core->addJS(url('assets/datatables/js/jquery.dataTables.min.js'));
        $this->core->addJS(url('assets/datatables/js/dataTables.buttons.min.js'));
        $this->core->addJS(url('assets/datatables/js/buttons.flash.min.js'));
        $this->core->addJS(url('assets/datatables/js/jszip_3.1.3_jszip.min.js'));
        $this->core->addJS(url('assets/datatables/js/vfs_fonts.js'));
        $this->core->addJS(url('assets/datatables/js/buttons.html5.min.js'));
        $this->core->addJS(url('assets/datatables/js/buttons.print.min.js'));
        $this->core->addJS(url('assets/datatables/js/dataTables.select.min.js'));

        $this->core->addCSS(url([ADMIN, 'NAMA_TABLE', 'css']));
        $this->core->addJS(url([ADMIN, 'NAMA_TABLE', 'javascript']), 'footer');
    }

}
