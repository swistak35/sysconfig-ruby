class Sysconfig
  #Linux distro name, ex. "Debian"
  def linux_id
    %x[lsb_release -is]
  end
  
  #Linux distro codename, ex. "sid"
  def linux_codename
    %x[lsb_release -cs]
  end
  
  #Linux distro release, ex. "unstable"
  def linux_release
    %x[lsb_release -rs]
  end
  
  #Linux distro full name, ex. "Debian GNU/Linux unstable (sid)"
  def linux_description
    %x[lsb_release -ds]
  end
  
  #Hostname, ex. "raptop"
  def hostname
    %x[uname -n]
  end
  
  #Kernel edition, ex. "2.6.32-5-686"
  def kernel_edition
    %x[uname -r]
  end
  
  #Kernel name, ex. "Linux"
  def kernel_name
    %x[uname -s]
  end
  
  #Kernel version, ex. "#1 SMP Fri Dec 10 16:12:40 UTC 2010"
  def kernel_version
    %x[uname -v]
  end
  
  #Architecture, ex. "i686"
  def arch
    %x[uname -m]
  end
  
  #TODO: Example
  #Processor type
  def processor
    %x[uname -p]
  end
  
  #TODO: Example
  #Hardware platform
  def hardware_plaftorm
    %x[uname -i]
  end
  
  #Operating system, ex. "GNU/Linux"
  def operating_system
    %x[uname -o]
  end
  
  #RAM total, ex. 2073056
  def ram_total
    %x[free -ot].split[7]
  end
  
  #RAM used, ex. 1801716
  def ram_used
    %x[free -ot].split[8]
  end
  
  #RAM free, ex. 271340
  def ram_free
    %x[free -ot].split[9]
  end
  
  #RAM shared, ex. 0 : P
  def ram_shared
    %x[free -ot].split[10]
  end
  
  #RAM buffers, ex. 384
  def ram_buffers
    %x[free -ot].split[11]
  end
  
  #RAM cached, ex. 1030316
  def ram_cached
    %x[free -ot].split[12]
  end
  
  #Swap total, ex. 1992024
  def swap_total
    %x[free -ot].split[14]
  end
  
  #Swap used, ex. 0 : D
  def swap_used
    %x[free -ot].split[15]
  end
  
  #Swap free, ex. 1992024
  def swap_free
    %x[free -ot].split[16]
  end
  
  #Memory (RAM + swap) total, ex. 4065080
  def memory_total
    %x[free -ot].split[18]
  end
  
  #Memory (RAM + swap) used, ex. 1801716
  def memory_used
    %x[free -ot].split[19]
  end
  
  #Memory (RAM + swap) free, ex. 2263364
  def memory_free
    %x[free -ot].split[20]
  end
  
  #Date, ex. śro, 15 gru 2010, 12:22:36 CET
  def date
    %x[date]
  end
  
  #Uptime, ex. 1:55
  def uptime
    %x[uptime].split[2][0..-2]
  end
  
  #Amount of partitions, without tmpfs, ex. "4"
  def filesystems_amount
    %x[df -hxtmpfs].to_i-1
  end
  
  #Filesystem type, ex. "ext3"
  def filesystem_type(name)
    filesystem_search name, 1
  end
  
  #Filesystem total size, ex. "19G"
  def filesystem_total(name)
    filesystem_search name, 2
  end
  
  #Filesystem used, ex. "13G"
  def filesystem_used(name)
    filesystem_search name, 3
  end
  
  #Filesystem free, ex. "4,9G"
  def filesystem_free(name)
    filesystem_search name, 4
  end
  
  #Filesystem used (percentage), ex. "73%"
  def filesystem_used_perc(name)
    filesystem_search name, 5
  end
  
  #Filesystem mount at, ex. "/"
  def filesystem_mount_at(name)
    filesystem_search name, 6
  end
  
  #Helper method to filesystem_ commands
  def filesystem_search(name,id)
    gen_var_filesystems
    info = ""
    @var_filesystems.each do |fs|
      info = fs[id] if fs[0]==name
    end
    info.to_s
  end
  
  #Helper method to filesystem_ commands
  def gen_var_filesystems
    if @var_filesystems.nil?
      @var_filesystems = %x[df -hT].split("\n")
      @var_filesystems.collect! do |line|
        line.split
      end
    end
  end
  
end

  #TODO:
  # Networking
  #@server_ifconfig = %x[/sbin/ifconfig]
  # Server Processes -> top mem & top cpu processes.
  #@server_processes_count = %x[top -n 1 -b |wc -l]
  #@server_processes = %x[top -n 1 -b]
