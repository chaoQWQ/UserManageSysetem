package com.usermanage.model;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    private  int code;
    private  String msg;



    private Map<String,Object> valList = new HashMap<String, Object>();

    public static Msg success(){
        Msg result = new Msg();
        result.setCode(200);
        result.setMsg("处理成功");
        return  result;
    }

    public static Msg fail(){
        Msg result = new Msg();
        result.setCode(100);
        result.setMsg("处理失败");
        return  result;
    }

    public Msg add(String key,Object value){
        this.getValList().put(key,value);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getValList() {
    return valList;
}

    public void setValList(Map<String, Object> valList) {
        this.valList = valList;
    }
}
